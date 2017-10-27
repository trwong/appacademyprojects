require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end

end

class SuperClass
  def self.find_by_id(id)
    id = id.to_i
    raise 'user does not have an id' unless id
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    #p user
    self.new(user.first)
  end

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| self.new(datum) }
  end
end

class User < SuperClass

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    p user
    User.new(user.first)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(questions_likes.user_id)AS FLOAT)/COUNT(DISTINCT questions.id)
      FROM
        users
      JOIN
        questions ON users.id = questions.user_id
      LEFT OUTER JOIN
        questions_likes ON questions.id = questions_likes.question_id
      WHERE
        questions.user_id = ?
    SQL
    karma.first.values.first
  end

end

class Question < SuperClass


  attr_accessor :title, :body, :user_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.find_by_author_id(author_id)
    authors_questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      user_id = ?
    SQL

    questions_arr = []

    authors_questions.each do |question|
      questions_arr << Question.new(question)
    end

    questions_arr
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end


  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id, @id)
        UPDATE
          users (title, body, user_id)
        SET
          title = ?, body = ?, user_id = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
        INSERT INTO
          users (title, body, user_id)
        VALUES
          (?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

end

class QuestionFollow < SuperClass


  attr_accessor :question_id, :user_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        users
      JOIN
        questions_follows ON users.id = questions_follows.user_id
      WHERE
        questions_follows.question_id = ?
    SQL

    follower_arr = []
    followers.each do |follower|
      follower_arr << User.new(follower)
    end

    follower_arr
  end

  def self.followed_questions_for_user_id(user_id)
    following = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions_follows
      WHERE
        user_id = ?
    SQL

    following_arr = []
    following.each do |followed|
      following_arr << Question.new(followed)
    end

    following_arr
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL,n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions_follows
      JOIN questions ON questions_follows.question_id = questions.id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    questions_arr = []

    questions.each do |question|
      questions_arr << Question.new(question)
    end

    questions_arr
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end


end

class Reply

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    Reply.new(reply.first)
  end

  attr_accessor :question_id, :user_id, :body, :parent_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    reply_arr = []

    replies.each do |reply|
      reply_arr << Reply.new(reply)
    end

    reply_arr
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    reply_arr = []

    replies.each do |reply|
      reply_arr << Reply.new(reply)
    end

    reply_arr
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    replies_arr = []

    replies.each do |reply|
      replies_arr << Reply.new(reply)
    end

    replies_arr
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @parent_id, @body, @user_id, @question_id, @id)
        UPDATE
          users (parent_id, body, user_id, question_id)
        SET
          parent_id = ?, body = ?, user_id = ?, question_id = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @parent_id, @body, @user_id, @question_id)
        INSERT INTO
          users (parent_id, body, user_id, question_id)
        VALUES
          (?, ?, ?, ?)
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

end

class QuestionLike < SuperClass

  attr_accessor :question_id, :user_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        questions_likes
      JOIN
        users ON questions_likes.user_id = users.id
      WHERE
        questions_likes.question_id = ?
    SQL

    users_arr = []

    users.each do |user|
      users_arr << User.new(user)
    end

    users_arr
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        questions_likes
      WHERE
        question_id = ?
    SQL

    num_likes.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions_likes
      JOIN
        questions ON questions.id = questions_likes.question_id
      WHERE
        questions_likes.user_id = ?
    SQL

    questions_arr = []

    questions.each do |question|
      questions_arr << Question.new(question)
    end

    questions_arr
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.id, questions.title, questions.body, questions.user_id
      FROM
        questions_likes
      JOIN
        questions ON questions.id = questions_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    question_arr = []
    questions.each do |question|
      question_arr << question
    end

    question_arr
  end

end
