class DocusignService
  def initialize
    @client = DocusignRest::Client.new
  end

  def init_envelope
    name = 'test.pdf'
    content = ApplicationController.render(
      formats: :html,
      template: "d_documents/#{name}.erb",
      assigns: { document: @document }
    )

    pdf = WickedPdf.new.pdf_from_string(content)
    file = Tempfile.new(["contract", ".pdf"])

    File.open(file, 'wb') do |f|
      f << pdf
    end
    files = [{ path: file.path, name: name }]
  end

  def send_envelope(files)
    document_envelope_response = @client.create_envelope_from_document(
      email: {
        subject: "TEST TEST TEST",
        body: "Bonjour futur associé, la société ------- a lancé les signatures dans le cadre de l'opération pour laquelle vous vous êtes engagé. <br>
              Veuillez trouver ci-joint les documents à signer. <br>
              <strong>Merci bien</strong>"
      },
      signers: [
        {
          embedded: false,
          name: 'Investisseur 1',
          email: 'mribot@hotmail.fr',
          role_name: 'Investisseur',
          sign_here_tabs: [
            {
              anchor_string: 'You should sign here:',
              anchor_x_offset: '140',
              anchor_y_offset: '8'
            }
          ]
        }
      ],
      files: files,
      status: 'sent'
    )
  end
end
