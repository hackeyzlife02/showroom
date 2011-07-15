module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "Showroom Admin"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "Showroom Admin", :class => "round")
  end
end
