package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.UIManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm2;
   import com.robot.core.utils.Direction;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import org.taomee.events.SocketEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_11064 extends BaseMapProcess
   {
      
      private var _timer:Timer;
      
      private var _exploitPorBar:MovieClip;
      
      public function MapProcess_11064()
      {
         super();
      }
      
      public function collectItem() : void
      {
         KTool.getMultiValue([12416],function(param1:Array):void
         {
            if(param1[0] < 10)
            {
               if(!_exploitPorBar)
               {
                  exploitNow();
                  StatManager.sendStat2014("0129全民打造龙王之冠","点击收集远古秘银","2016运营活动");
               }
            }
            else
            {
               Alarm2.show("当日已经到上限了哦！请明天再来吧！");
            }
         });
      }
      
      private function exploitNow() : void
      {
         this.addProBar();
         this._timer = new Timer(1000,3);
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOver);
         this._timer.start();
         MapManager.addEventListener(MapEvent.MAP_DESTROY,this.onMap);
         MainManager.actorModel.sprite.addEventListener(RobotEvent.WALK_START,this.onWalk);
         MainManager.actorModel.direction = Direction.DOWN;
      }
      
      private function addProBar() : void
      {
         if(!this._exploitPorBar)
         {
            this._exploitPorBar = UIManager.getMovieClip("ExploitPorBarMC");
         }
         this._exploitPorBar.y = -80;
         this._exploitPorBar.gotoAndStop(1);
         MainManager.actorModel.addChild(this._exploitPorBar);
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         this._exploitPorBar.gotoAndStop(param1.target.currentCount * 16);
      }
      
      private function onTimeOver(param1:TimerEvent) : void
      {
         var evt:TimerEvent = param1;
         this.destroyMineAnima();
         this._exploitPorBar.addEventListener(Event.ENTER_FRAME,function(param1:Event):void
         {
            if(_exploitPorBar)
            {
               if(_exploitPorBar.currentFrame == _exploitPorBar.totalFrames)
               {
                  _exploitPorBar.removeEventListener(Event.ENTER_FRAME,arguments.callee);
                  DisplayUtil.removeForParent(_exploitPorBar);
                  _exploitPorBar = null;
               }
            }
         });
         this._exploitPorBar.gotoAndPlay(51);
         SocketConnection.sendWithCallback(47270,function(param1:SocketEvent):void
         {
         },2,2,0,0);
      }
      
      private function onMap(param1:MapEvent) : void
      {
         this.destroyMineAnima();
         this._exploitPorBar.removeEventListener(Event.ENTER_FRAME,arguments.callee);
         DisplayUtil.removeForParent(this._exploitPorBar);
         this._exploitPorBar = null;
      }
      
      private function onWalk(param1:RobotEvent) : void
      {
         this.destroyMineAnima();
         this._exploitPorBar.removeEventListener(Event.ENTER_FRAME,arguments.callee);
         DisplayUtil.removeForParent(this._exploitPorBar);
         this._exploitPorBar = null;
      }
      
      private function destroyMineAnima() : void
      {
         if(this._timer)
         {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimeOver);
            this._timer = null;
         }
         MapManager.removeEventListener(MapEvent.MAP_DESTROY,this.onMap);
         MainManager.actorModel.stop();
         MainManager.actorModel.sprite.removeEventListener(RobotEvent.WALK_START,this.onWalk);
      }
   }
}

