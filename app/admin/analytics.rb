ActiveAdmin.register_page "Analytics" do

  metabase_site_url = Rails.application.secrets.metabase_site_url
  metabase_secret_key = Rails.application.secrets.metabase_secret_key

	payload = {
    :resource => { :dashboard => 1 },
	  :params => {

	  }
	}

  unless Rails.env.test? # don't run in test
    token = JWT.encode payload, metabase_secret_key
    content do
      iframe_url = metabase_site_url + "/embed/dashboard/" + token + "#bordered=true&titled=false"
      text_node %{<iframe src="#{iframe_url}" onload="iFrameResize({}, this)" width="100%" height="600" scrolling="no" frameborder="no" allowtransparency></iframe> }.html_safe
    end
  end

end
