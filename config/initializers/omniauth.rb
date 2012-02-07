Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == "production"
    provider :facebook, '326858757357937', '1370c9bef67b62532be4dbe516292f5d'
  else
    provider :facebook, '343838685637455', '2177c742e4bf8011bad450ce32d92eb8'
  end
end