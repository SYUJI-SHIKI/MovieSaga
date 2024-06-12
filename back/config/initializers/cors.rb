Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '127.0.0.1:4000', 'localhost:4000', 'https://moviesaga-git-main-syuzi-iidas-projects.vercel.app/'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end