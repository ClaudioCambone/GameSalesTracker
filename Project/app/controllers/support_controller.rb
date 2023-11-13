class SupportController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        # cacca pipì pupù
    end
end
