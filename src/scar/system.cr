module Scar
  abstract class System
    property :initialized
    @initialized = false

    def init(app : App, space : Space); end

    def update(app : App, space : Space, dt); end

    def render(app : App, space : Space, dt); end
  end # End class System
end   # End module Scar
