require 'printing/main_printer'
module BrandOrderItemsPrinter
  include MainPrinter
  include ActionView::Helpers::NumberHelper

  def print_form(order_items)
    document = Prawn::Document.new do |pdf|
      print_brand_order_items_form(pdf, order_items)
      pdf#.render#_file card_name
    end # end of Prawn::Document.generate
    return document
  end # end of print_form method

  def print_order_items_background(pdf, png_background = "#{Rails.root}/public/images/reports/brand_order_items_template.png")
    pdf.bounding_box([10,730], :width => 530) do
      pdf.image png_background, :width => 519 if png_background
    end
    #pdf.bounding_box([20,720], :width => 120) do
    #  pdf.image "#{Rails.root}/public/images/logos/#{Image::MAIN_LOGO}.png"
    #end
  end

  def print_brand_order_items_form( pdf,
                              order_items,
                              file_to_load = "#{Rails.root}/lib/printing/x_y_locations/brand_order_items.yml" )

    @order_items_yml    = YAML::load( File.open( file_to_load ) )
    pdf.font "#{Rails.root}/lib/printing/fonts/DejaVuSans.ttf"
    print_order_items_background(pdf)
    #new_page(pdf)
    order_specific_details(pdf, order_items)
  end

  def order_specific_details(pdf, order_items)
    adjusted_prices = []
    i = 0
    order_items.find_in_batches(:batch_size => 50) do |items| #.find_in_batches(:batch_size => 50)
      items.each do |item|
        new_page(pdf) if ((i) % 24) == 0 && i > 1
        pdf.draw_text item.order_number,                        {:at => [27 , 620 - (i * 27) ], :size => 10}
        pdf.draw_text item.variant.product_name,                {:at => [97 , 620 - (i * 27) ], :size => 8}
        pdf.draw_text item.variant.sku,                         {:at => [180, 620 - (i * 27) ], :size => 8}
        pdf.draw_text item.order.display_completed_at,          {:at => [270, 620 - (i * 27) ], :size => 10}
        pdf.draw_text item.display_paid_at,                     {:at => [350, 620 - (i * 27) ], :size => 10}
        pdf.draw_text number_to_currency(item.adjusted_price),  {:at => [420, 620 - (i * 27) ], :size => 10}
        pdf.draw_text number_to_currency(item.price),           {:at => [475, 620 - (i * 27) ], :size => 10}
        adjusted_prices << item.adjusted_price
        i = i + 1
      end
    end
    pdf.draw_text number_to_currency(adjusted_prices.sum),           {:at => [475, 70  ], :size => 11}
  end

  def new_page(pdf)
    pdf.start_new_page()
    pdf.font "#{Rails.root}/lib/printing/fonts/DejaVuSans.ttf"
    print_order_items_background(pdf)
  end

end