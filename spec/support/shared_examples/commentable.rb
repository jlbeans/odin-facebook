shared_example 'a commentable' do
  describe 'PATCH #update' do
    it 'updates the requested comment' do

      send('#{klass.downcase}_comment_url', @commentable, comment)
      patch post_comment_url(@commentable, comment), params: { comment: { body: 'Nice!'} }
      comment.reload
      expect(response).to redirect_to()
    end
  end
end
