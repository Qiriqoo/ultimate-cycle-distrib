prawn_document do |pdf|
  pdf.define_grid(columns: 5, rows: 8, gutter: 10)

  @font_face = 'Helvetica'
  @font_size = 14

  # HEADER
  im = "#{Rails.root}/public/logo.png"
  if File.exist? im
    pdf.image im, vposition: :top, height: 40
  end

  pdf.font @font_face, size: @font_size
  pdf.text Spree.t('orders_export_column_names.invoice'), align: :right, style: :bold, size: 18
  pdf.move_down 4
  pdf.text Spree.t('orders_export_column_names.order_number', number: @order.number), align: :right
  pdf.move_down 2
  pdf.text I18n.l(@order.completed_at.to_date), align: :right

  # CONTENT

  pdf.font @font_face, size: @font_size

  # address block on first page only
  bill_address = @order.bill_address
  ship_address = @order.ship_address

  pdf.move_down 2
  address_cell_billing  = pdf.make_cell(content: Spree.t(:billing_address), font_style: :bold)
  address_cell_shipping = pdf.make_cell(content: Spree.t(:shipping_address), font_style: :bold)

  billing =  "#{bill_address.firstname} #{bill_address.lastname}"
  billing << "\n#{bill_address.address1}"
  billing << "\n#{bill_address.address2}" unless bill_address.address2.blank?
  billing << "\n#{bill_address.city}, #{bill_address.state_text} #{bill_address.zipcode}"
  billing << "\n#{bill_address.country.name}"
  billing << "\n#{bill_address.phone}"

  shipping =  "#{ship_address.firstname} #{ship_address.lastname}"
  shipping << "\n#{ship_address.address1}"
  shipping << "\n#{ship_address.address2}" unless ship_address.address2.blank?
  shipping << "\n#{ship_address.city}, #{ship_address.state_text} #{ship_address.zipcode}"
  shipping << "\n#{ship_address.country.name}"
  shipping << "\n#{ship_address.phone}"
  shipping << "\n\n#{Spree.t('orders_export_column_names.via')} #{@order.shipments.first.shipping_method.name}"

  data = [[address_cell_billing, address_cell_shipping], [billing, shipping]]
  pdf.table(data, position: :center)

  pdf.move_down 10

  header = [
    pdf.make_cell(content: Spree.t(:sku)),
    pdf.make_cell(content: Spree.t(:item_description)),
    pdf.make_cell(content: Spree.t(:price)),
    pdf.make_cell(content: Spree.t(:qty)),
    pdf.make_cell(content: Spree.t(:total))
  ]
  data = [header]

  @order.line_items.each do |item|
    row = [
      item.variant.sku,
      item.variant.name,
      item.single_display_amount.to_s,
      item.quantity,
      item.display_total.to_s
    ]
    data += [row]
  end

  pdf.table(data, header: true, position: :right) do
    row(0).style align: :center, font_style: :bold
    column(0..2).style align: :left
    column(3..6).style align: :right
  end

  # TOTALS
  pdf.move_down 10
  totals = []

  # Subtotal
  totals << [pdf.make_cell(content: Spree.t(:subtotal)), @order.display_item_total.to_s]

  # Adjustments
  @order.all_adjustments.eligible.each do |adjustment|
    totals << [pdf.make_cell(content: adjustment.label), adjustment.display_amount.to_s]
  end

  # Shipments
  @order.shipments.each do |shipment|
    totals << [pdf.make_cell(content: shipment.shipping_method.name), shipment.display_cost.to_s]
  end

  # Totals
  totals << [pdf.make_cell(content: Spree.t(:order_total)), @order.display_total.to_s]

  # Payments
  total_payments = 0.0
  @order.payments.each do |payment|
    total_payments += payment.amount
  end

  pdf.table(totals, position: :right) do
    row(0..6).style align: :right
    column(0).style borders: [], font_style: :bold
  end

  pdf.move_down 30

  pdf.grid([7,0], [7,4]).bounding_box do

    data  = []
    data << [pdf.make_cell(content: 'EURL Ultimate Cycle Distribution - SIRET 807 977 307 00014 - APE 4649z - RCS Auch - Rue Pascal Cytron, 32810 PREIGNAN - Tel : 05 62 07 93 38', colspan: 2, align: :center)]
    data << [pdf.make_cell(content: '', colspan: 2)]

    pdf.table(data, position: :center) do
      row(0..2).style borders: []
    end
  end
end
