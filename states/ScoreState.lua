--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local goodScore = 5
local greatScore = 8
local amazingScore = 12
local star = love.graphics.newImage('Star.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    star = love.graphics.newImage('Star.png')
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown', {
            bird = Bird(),
            pipePairs = {},
            score = 0,
            timer = 0
        })
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

    if self.score >= amazingScore then
        love.graphics.printf('You did amazing!', 0, 180, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(star, VIRTUAL_WIDTH / 2 - 32, 200, 0, 0.5)
        love.graphics.draw(star, VIRTUAL_WIDTH / 2 + 32, 200, 0, 0.5)
        love.graphics.draw(star, VIRTUAL_WIDTH / 2 - 96, 200, 0, 0.5)
    elseif self.score >= greatScore then
        love.graphics.printf('You did great!', 0, 180, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(star, VIRTUAL_WIDTH / 2, 200, 0, 0.5)
        love.graphics.draw(star, VIRTUAL_WIDTH / 2 - 64, 200, 0, 0.5)
    elseif self.score >= goodScore then
        love.graphics.printf('You did well!', 0, 180, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(star, VIRTUAL_WIDTH / 2 - 32, 200, 0, 0.5)
    end
end