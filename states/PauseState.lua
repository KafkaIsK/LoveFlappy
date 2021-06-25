PauseState = Class{__includes = BaseState}

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('countdown', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            score = self.score,
            timer = self.timer
        })
        sounds['blip']:play()
        
    end
end

function PauseState:render()
    scrolling = false
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Paused', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press P to resume', 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end

function PauseState:enter(params)
    scrolling = false

    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.score = params.score
    self.timer = params.timer
    love.audio.pause(sounds['music'])
    love.audio.play(sounds['blip'])
    -- sounds['blip']:play()
end

function PauseState:exit()
    -- scrolling = true
    love.audio.play(sounds['music'])
end