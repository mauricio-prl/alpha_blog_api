User.create(username: 'mauricio-p', email: 'mauricio@email.com', password: 'password')
User.create(username: 'admin', email: 'admin@email.com', password: 'password', admin: true)

Category.create(name: 'Sports')

Article.create(
  title: 'Hello!', 
  description: 'This is a simple hello!', 
  user_id: User.first.id, 
  category_ids: [Category.first.id]
)
