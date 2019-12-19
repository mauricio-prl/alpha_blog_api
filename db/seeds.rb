User.create(username: 'mauricio-p', email: 'mauricio@email.com', password: '515442')

Category.create(name: 'Sports')

Article.create(
  title: 'Hello!', 
  description: 'This is a simple hello!', 
  user_id: User.first.id, 
  category_ids: [Category.first.id]
)
