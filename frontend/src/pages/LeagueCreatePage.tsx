import { useEffect, useRef, useState } from 'react';
import { ApiError, apiManagement } from '../api';
import PageTemplate from './PageTemplate';
import '../template/css/Form.css';
import './CreateEntityPage.css';

interface AssociationRow {
  association_id: number;
  association: string;
}

interface LeagueFormState {
  description: string;
  logo_path: string;
  association_id: string;
}

function generateHashValue(): string {
  if (typeof crypto !== 'undefined' && typeof crypto.getRandomValues === 'function') {
    const bytes = new Uint8Array(32);
    crypto.getRandomValues(bytes);
    return Array.from(bytes, (byte) => byte.toString(16).padStart(2, '0')).join('');
  }

  const chars = 'abcdef0123456789';
  let result = '';
  for (let index = 0; index < 64; index += 1) {
    result += chars[Math.floor(Math.random() * chars.length)];
  }
  return result;
}

function createInitialLeagueState(): LeagueFormState {
  return {
    description: '',
    logo_path: '',
    association_id: '',
  };
}

function LeagueCreatePage() {
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [associations, setAssociations] = useState<AssociationRow[]>([]);
  const [formState, setFormState] = useState<LeagueFormState>(() => createInitialLeagueState());
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [logoPreview, setLogoPreview] = useState<string | null>(null);
  const [loadingAssociations, setLoadingAssociations] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [uploadingFile, setUploadingFile] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  useEffect(() => {
    let mounted = true;

    async function loadAssociations() {
      setLoadingAssociations(true);
      setError(null);

      try {
        const response = await apiManagement.masterData.associations.list({ limit: 100, sortBy: 'association_id' });
        if (!mounted) {
          return;
        }

        setAssociations(
          response.rows
            .map((row) => ({
              association_id: Number(row.association_id ?? 0),
              association: String(row.association ?? ''),
            }))
            .filter((entry) => entry.association_id > 0)
        );
      } catch (loadError) {
        if (!mounted) {
          return;
        }

        setError(loadError instanceof Error ? loadError.message : 'Verbände konnten nicht geladen werden.');
      } finally {
        if (mounted) {
          setLoadingAssociations(false);
        }
      }
    }

    void loadAssociations();

    return () => {
      mounted = false;
    };
  }, []);

  const canSubmit = Boolean(
    !submitting
    && !loadingAssociations
    && !uploadingFile
    && formState.description.trim()
    && formState.association_id
  );

  const updateField = <K extends keyof LeagueFormState>(field: K, value: LeagueFormState[K]) => {
    setFormState((previous) => ({ ...previous, [field]: value }));
  };

  const handleFileSelect = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) {
      return;
    }

    // Validate file size (5MB max)
    if (file.size > 5 * 1024 * 1024) {
      setError('Datei ist zu groß. Maximal 5MB erlaubt.');
      return;
    }

    // Validate file type
    const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
    if (!allowedTypes.includes(file.type)) {
      setError('Dateityp nicht erlaubt. Erlaubte Typen: JPEG, PNG, GIF, WebP');
      return;
    }

    setSelectedFile(file);
    setError(null);

    // Create preview
    const reader = new FileReader();
    reader.onload = (e) => {
      setLogoPreview(e.target?.result as string);
    };
    reader.readAsDataURL(file);
  };

  const handleUploadLogo = async () => {
    if (!selectedFile) {
      return;
    }

    setUploadingFile(true);
    setError(null);

    try {
      const uploadResponse = await apiManagement.files.uploadLogo(selectedFile);
      updateField('logo_path', uploadResponse.path);
      setSuccess(`Logo erfolgreich hochgeladen: ${uploadResponse.filename}`);
    } catch (uploadError) {
      setError(uploadError instanceof Error ? uploadError.message : 'Logo-Upload fehlgeschlagen');
      setSelectedFile(null);
      setLogoPreview(null);
    } finally {
      setUploadingFile(false);
    }
  };

  const handleRemoveLogo = () => {
    setSelectedFile(null);
    setLogoPreview(null);
    updateField('logo_path', '');
    if (fileInputRef.current) {
      fileInputRef.current.value = '';
    }
  };

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSubmitting(true);
    setError(null);
    setSuccess(null);

    try {
      const response = await apiManagement.leagues.create({
        description: formState.description.trim(),
        logo_path: formState.logo_path.trim() || null,
        association_id: Number(formState.association_id),
        league_hash_value: generateHashValue(),
      });

      setSuccess(
        response.row?.league_id
          ? `Liga erfolgreich angelegt (ID: ${String(response.row.league_id)}).`
          : 'Liga erfolgreich angelegt.'
      );
      setFormState(createInitialLeagueState());
      setSelectedFile(null);
      setLogoPreview(null);
    } catch (submitError) {
      if (submitError instanceof ApiError) {
        setError(submitError.message);
      } else {
        setError(submitError instanceof Error ? submitError.message : 'Liga konnte nicht angelegt werden.');
      }
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <PageTemplate
      eyebrow="Ligen"
      title="Liga anlegen"
      description="Erster Schritt für lm_league: Name, Logo und Verband."
      primaryAction={{ label: 'Ligen verwalten', to: '/ligen/verwalten' }}
    >
      <form className="ui-form entity-create-form" onSubmit={handleSubmit}>
        <h2>Liga anlegen</h2>

        {error ? <p className="entity-create-form__message entity-create-form__message--error">{error}</p> : null}
        {success ? <p className="entity-create-form__message entity-create-form__message--success">{success}</p> : null}

        <div className="ui-form__row">
          <div className="ui-form__col ui-field">
            <label className="ui-field__label" htmlFor="league-name">Name *</label>
            <input
              className="ui-control"
              type="text"
              id="league-name"
              value={formState.description}
              onChange={(event) => updateField('description', event.target.value)}
              placeholder="z.B. Bayernliga Inlinehockey"
              required
            />
          </div>
        </div>

        <div className="ui-form__row">
          <div className="ui-form__col ui-field">
            <label className="ui-field__label" htmlFor="league-logo">Logo hochladen</label>
            <div style={{ display: 'flex', gap: '1rem', alignItems: 'flex-start' }}>
              <div style={{ flex: 1 }}>
                <input
                  ref={fileInputRef}
                  className="ui-control"
                  type="file"
                  id="league-logo"
                  accept="image/jpeg,image/png,image/gif,image/webp"
                  onChange={handleFileSelect}
                  disabled={uploadingFile}
                />
                <small style={{ display: 'block', marginTop: '0.25rem', opacity: 0.7 }}>
                  Unterstützte Formate: JPEG, PNG, GIF, WebP (max. 5MB)
                </small>
              </div>
              {selectedFile && (
                <button
                  type="button"
                  onClick={handleUploadLogo}
                  disabled={uploadingFile || !selectedFile}
                  style={{ marginTop: '0.375rem' }}
                >
                  {uploadingFile ? 'Wird hochgeladen...' : 'Hochladen'}
                </button>
              )}
            </div>

            {logoPreview && (
              <div style={{ marginTop: '1rem', display: 'flex', gap: '1rem', alignItems: 'center' }}>
                <img
                  src={logoPreview}
                  alt="Logo Preview"
                  style={{ maxHeight: '100px', maxWidth: '200px', border: '1px solid #ccc', borderRadius: '4px' }}
                />
                <button
                  type="button"
                  className="is-quiet"
                  onClick={handleRemoveLogo}
                  disabled={uploadingFile}
                >
                  Entfernen
                </button>
              </div>
            )}

            {formState.logo_path && (
              <div style={{ marginTop: '0.5rem', padding: '0.5rem', backgroundColor: '#e8f5e9', borderRadius: '4px' }}>
                <small style={{ color: '#2e7d32' }}>
                  <strong>Hochgeladen:</strong> {formState.logo_path}
                </small>
              </div>
            )}
          </div>
        </div>

        <div className="ui-form__row">
          <div className="ui-form__col ui-field">
            <label className="ui-field__label" htmlFor="league-association">Verband *</label>
            <select
              className="ui-control"
              id="league-association"
              value={formState.association_id}
              onChange={(event) => updateField('association_id', event.target.value)}
              disabled={loadingAssociations}
              required
            >
              <option value="">Bitte wählen</option>
              {associations.map((association) => (
                <option key={association.association_id} value={String(association.association_id)}>
                  {association.association}
                </option>
              ))}
            </select>
          </div>
        </div>

        <div className="ui-form__actions">
          <button type="button" className="is-quiet" onClick={() => {
            setFormState(createInitialLeagueState());
            setSelectedFile(null);
            setLogoPreview(null);
            setError(null);
            setSuccess(null);
            if (fileInputRef.current) {
              fileInputRef.current.value = '';
            }
          }} disabled={submitting || uploadingFile}>
            Zurücksetzen
          </button>
          <button type="submit" disabled={!canSubmit}>
            {submitting ? 'Wird erstellt...' : 'Liga erstellen'}
          </button>
        </div>
      </form>
    </PageTemplate>
  );
}

export default LeagueCreatePage;
