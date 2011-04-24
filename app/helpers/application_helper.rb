module ApplicationHelper
  def layout_menu_item(label, url)
    if controller_name == "home"
      if action_name == label.downcase
        "<li class='current_page_item'>#{link_to(label, url)}</li>"
      else
        "<li>#{link_to(label, url)}</li>"
      end
    elsif controller_name == label.downcase
      "<li class='current_page_item'>#{link_to(label, url)}</li>"
    else
      "<li>#{link_to(label, url)}</li>"
    end
  end
  
  def detail_row(title, value)
    "<tr><th>#{title}</th><td>#{value}</td></tr>"
  end
end
