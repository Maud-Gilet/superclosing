class DocusignService
  def initialize
    @client = DocusignRest::Client.new
  end

  def init_envelope
    content = ApplicationController.render(
      formats: :html,
      template: 'documents/show.pdf.erb',
      assigns: { document: @document }
    )

    pdf = WickedPdf.new.pdf_from_string(content)
    file = Tempfile.new(["contract", ".pdf"])

    File.open(file, 'wb') do |f|
      f << pdf
    end
  end

  def send_envelope
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
      files: [ { path: 'lib/assets/test.pdf', name: 'test.pdf' } ],
      status: 'sent'
    )
  end
end
