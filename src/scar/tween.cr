module Scar
  class Tween
    # Basic easing functions
    module Easing
      Linear         = ->(lf : Float32) { lf }
      EaseInQuad     = ->(lf : Float32) { lf ** 2 }
      EaseOutQuad    = ->(lf : Float32) { lf * (2 - lf) }
      EaseInOutQuad  = ->(lf : Float32) { lf < 0.5 ? 2 * lf ** 2 : -1 + (4 - 2 * lf) * lf }
      EaseInCubic    = ->(lf : Float32) { lf ** 3 }
      EaseOutCubic   = ->(lf : Float32) { (lf - 1) ** 3 + 1 }
      EaseInOutCubic = ->(lf : Float32) { lf < 0.5 ? 4 * lf ** 3 : (lf - 1) * (2 * lf - 2) ** 2 + 1 }
      EaseInQuart    = ->(lf : Float32) { lf ** 4 }
      EaseOutQuart   = ->(lf : Float32) { 1 - (lf - 1) ** 4 }
      EaseInOutQuart = ->(lf : Float32) { lf < 0.5 ? 8 * lf ** 4 : 1 - 8 * (lf - 1) ** 4 }
      EaseInQuint    = ->(lf : Float32) { lf ** 5 }
      EaseOutQuint   = ->(lf : Float32) { 1 + (lf - 1) ** 5 }
      EaseInOutQuint = ->(lf : Float32) { lf < 0.5 ? 16 * lf ** 5 : 1 + 16 * (lf - 1) ** 5 }
    end

    property :on_update
    property :on_complete

    def initialize(duration : Float32, ease : Proc(Float32, Float32), on_update : Proc(Tween, Nil) = ->{}, on_complete : Proc(Tween, Nil) = ->{})
      initialize(duration, kind.new, on_update, on_complete)
    end

    def initialize(@duration : Float32, @ease : Proc(Float32, Float32), @on_update : Proc(Tween, Nil), @on_complete : Proc(Tween, Nil))
      @time_spent = 0f32
    end

    # Returns the current linear interpolated fraction
    def linear_fraction
      raw_fraction = @time_spent / @duration
      raw_fraction > 1f32 ? 1f32 : raw_fraction
    end

    # Returns the current interpolated fraction (defined by the kind)
    def fraction
      @ease.call(linear_fraction)
    end

    def complete?
      linear_fraction == 1f32
    end

    # Sets @time_spent to 0 / starts the tween over.
    def reset
      @time_spent = 0f32
    end

    def update(delta_time)
      @time_spent += delta_time
      @on_update.call(self)
      if complete?
        @on_complete.call(self)
      end
    end
  end # End class Tween
end   # End module Scar