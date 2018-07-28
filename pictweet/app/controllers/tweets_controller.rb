class TweetsController < ApplicationController

    before_action :move_to_index, except: [:index,:show]

    #ActionName
    def index
        @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
        #@tweets = Tweet.all.order("id DESC").page(params[:page]).per(5)
        #変数名 = クラスを利用して取得したレコードのインスタンス.page(params[:page]).per(ここに1ページで表示したい件数を入力)
    end

    def new
    end

    # def create
    #     Tweets.create(name: "params[:name]", image: "params[:image]", text:"params[:text]")
    # end

    def create
        #Tweet.create(tweet_params)
        #Tweet.create(name: tweet_params[:name], image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
        Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
    end

    def destroy
        tweet = Tweet.find(params[:id])
        # if tweet.user_id == current_user.id
        #     tweet.destroy
        # end
        tweet.destroy if tweet.user_id == current_user.id
    end

    def edit
        @tweet = Tweet.find(params[:id])
    end

    def update
        tweet = Tweet.find(params[:id])
        tweet.update(tweet_params) if tweet.user_id == current_user.id
    end

    def show
        @tweet = Tweet.find(params[:id])
        @comments = @tweet.comments.includes(:user)
    end

    def move_to_index
        redirect_to action: :index unless user_signed_in?
    end
    # # 今回やりたいことは、ログインしていないユーザーが/tweets/newにアクセスできないように、
    # newアクションを動かす前に強制的にindexアクションにリダイレクトする(indexアクションを動かす)ことです。
    # そのためには、①リダイレクト用のメソッドを定義する ②new、createアクションを動かす前に①で定義したメソッドを動かす設定をする、
    # という2つの工程が必要です。

    # # まずは、①から解説していきます。①のリダイレクト用に定義したメソッドが、move_to_indexです。
    # 22行目のredirect_toメソッドが、具体的に①の役割を果たしています。
    # redirect_toメソッドの引数は、action: :同一コントローラ内の実行したいアクション名とします。
    # 今回は同一コントローラ内のindexアクションに遷移したかったため、このようにしています。unless ~と続いているのはunless文です。
    # このように書くと、先にuser_signed_in?で判定をして、その返り値がfalseだった場合に手前の式を実行するということになります。
    # # つまり、ユーザーがログインしていない時にindexアクションを実行するよ、ということになります。

    # # 続いて、②の解説をします。before_actionとは、そのコントローラー内のすべてのアクションが動く前に動くメソッドを設定することができます。
    # また、before_actionで設定したメソッドを、特定のアクションの前にだけ動くように設定することもできます。
    # 今回は、except: :indexとすることで、①で定義したmove_to_indexをnewアクションとcreateアクションの前でのみ動かすように設定しています。
    private
    def tweet_params
        # params.permit(:name, :image, :text)
        params.permit(:image, :text)
    end
    #16行目で利用されているpermitというメソッドは、
    # ビューから送られてきた情報のハッシュであるparamsの中から
    # :name, :image, :textというキーとそのバリューのセットだけを残した新たなハッシュを生成しています。
    # この新たなハッシュが、tweet_paramsメソッドの返り値です。
end
