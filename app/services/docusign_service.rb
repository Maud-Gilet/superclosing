class DocusignService
  def initialize(document_id, user_id)
    @client = DocusignRest::Client.new
    @d_document = DDocument.find(document_id)
    @operation = @d_document.operation
    @user = User.find(user_id)
    @pv_opening = DDocument.where(operation: @operation, document_type: "pv_opening")
  end

  def init_envelope_bs
    bs_variables_for_show
    @user_first_name = @user.first_name

    name = 'show.html'
    content = ApplicationController.render_with_signed_in_user(
      @user,
      formats: :html,
      template: "d_documents/#{name}.erb",
      assigns: {  d_document: @d_document,
                  operation: @operation,
                  user: @user,
                  user_investment: @user_investment,
                  pv_opening: @pv_opening,
                  nominal: @nominal,
                  total_of_shares: @total_of_shares,
                  capital_augmentation: @capital_augmentation }
    )

    pdf = WickedPdf.new.pdf_from_string(content)
    file = Tempfile.new([@d_document.title.to_s, ".pdf"])

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

  private

  def total_of_shares_number
    array_of_shares = []

    @operation.investments.each do |investment|
      array_of_shares << investment.number_of_shares
    end
    @total_of_shares = array_of_shares.sum
  end

  def bs_variables_for_show
    @user_investment = @user.investments.where(operation_id: @operation.id).last

    @nominal = @operation.company.share_nominal_value

    total_of_shares_number

    @capital_augmentation = @total_of_shares * @nominal
  end
end
