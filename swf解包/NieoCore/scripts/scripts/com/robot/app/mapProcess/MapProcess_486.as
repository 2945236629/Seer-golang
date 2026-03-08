package com.robot.app.mapProcess
{
   import com.robot.app.fightNote.FightInviteManager;
   import com.robot.app.spt.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.*;
   import org.taomee.utils.*;
   
   public class MapProcess_486 extends BaseMapProcess
   {
      
      private var _bossMc:MovieClip;
      
      private var _clickBtn:SimpleButton;
      
      private var _d:Date;
      
      private var _isX:Boolean = false;
      
      private var _totalF:uint;
      
      public function MapProcess_486()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(TasksManager.getTaskStatus(619) == TasksManager.ALR_ACCEPT)
         {
            Task620.delAll(this);
            DisplayUtil.removeForParent(this.conLevel["bossMc"]);
            this.conLevel["bossMc"] = null;
            return;
         }
         this._bossMc = this.conLevel["bossMc"];
         this._d = new Date(SystemTimerManager.time * 1000);
         if(this._d.getHours() >= 19 && this._d.getHours() <= 20)
         {
            this._isX = true;
            this._totalF = 289;
         }
         else
         {
            this._isX = false;
            this._totalF = this._bossMc.totalFrames;
         }
         this._bossMc.addEventListener(Event.ENTER_FRAME,this.onE1Handler);
      }
      
      private function onE1Handler(param1:Event) : void
      {
         if(Boolean(this._bossMc["btn"]))
         {
            this._bossMc.removeEventListener(Event.ENTER_FRAME,this.onE1Handler);
            this._clickBtn = this._bossMc["btn"];
            this._clickBtn.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._bossMc.currentFrame == 1 || this._bossMc.currentFrame == 6 || this._bossMc.currentFrame == 38)
         {
            this._bossMc.gotoAndPlay(this._bossMc.currentFrame + 1);
         }
         else
         {
            if(this._bossMc.currentFrame == 289)
            {
               if(this._isX)
               {
                  this.fight();
               }
               else
               {
                  this._bossMc.gotoAndPlay(this._bossMc.currentFrame + 1);
               }
            }
            if(this._bossMc.currentFrame == this._bossMc.totalFrames)
            {
               this.fight();
            }
         }
      }
      
      private function fight() : void
      {
         this._d = new Date(SystemTimerManager.time * 1000);
         if(this._d.getHours() >= 19 && this._d.getHours() <= 20)
         {
            FightInviteManager.fightWithBoss("德拉萨",1,true);
         }
         else
         {
            FightInviteManager.fightWithBoss("德拉萨",0,true);
         }
      }
      
      override public function destroy() : void
      {
         if(Boolean(this._bossMc))
         {
            this._bossMc.removeEventListener(Event.ENTER_FRAME,this.onE1Handler);
         }
         if(Boolean(this._clickBtn))
         {
            this._clickBtn.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         }
      }
      
      public function getKeyHandler() : void
      {
         Task620.getKeyHandler();
      }
      
      public function npcClickHandler() : void
      {
         Task620.npcClickHandler();
      }
   }
}

