prawn_document do |pdf|
   pdf.move_down 70

  # Add the font style and size
  pdf.font "Helvetica"
  pdf.font_size 18
  pdf.text_box "Numéro de commande ##{@order.number}", align: :center
  pdf.move_down 20

  pdf.font_size 14
  pdf.text "Below you can find your order details. We hope you shop with Awesome Company again in the future. Now unleash those fonts like hell have no fury!", align: :center
end
