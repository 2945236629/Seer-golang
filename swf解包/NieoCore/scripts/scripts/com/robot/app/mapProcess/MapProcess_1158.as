package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.UIManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm2;
   import com.robot.core.utils.Direction;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getDefinitionByName;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_1158 extends BaseMapProcess
   {
      
      private var currType:int = 0;
      
      private var _timer:Timer;
      
      private var _exploitPorBar:MovieClip;
      
      public function MapProcess_1158()
      {
         super();
      }
      
      public function collectKeel() : void
      {
         ItemManager.updateItems([1707926],function():void
         {
            var _loc1_:int = int(ItemManager.getNumByID(1707926));
            if(_loc1_ < 10)
            {
               exploitNow(1);
            }
            else
            {
               Alarm2.show("您已收集齐了龙之骨灰，不能获得更多");
            }
         });
         StatManager.sendStat2014("0115龙纹徽章的共鸣","点击龙骨采集龙之骨灰","2016运营活动");
      }
      
      public function collectWater() : void
      {
         ItemManager.updateItems([1707924],function():void
         {
            var _loc1_:int = int(ItemManager.getNumByID(1707924));
            if(_loc1_ < 10)
            {
               exploitNow(2);
            }
            else
            {
               Alarm2.show("您已收集齐了万渊之水，不能获得更多");
            }
         });
         StatManager.sendStat2014("0115龙纹徽章的共鸣","点击河流采集万渊之水","2016运营活动");
      }
      
      private function exploitNow(param1:int) : void
      {
         this.addProBar();
         this.currType = param1;
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
         this._exploitPorBar = UIManager.getMovieClip("ExploitPorBarMC");
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
            if(_exploitPorBar.currentFrame == _exploitPorBar.totalFrames)
            {
               _exploitPorBar.removeEventListener(Event.ENTER_FRAME,arguments.callee);
               DisplayUtil.removeForParent(_exploitPorBar);
               _exploitPorBar = null;
            }
         });
         this._exploitPorBar.gotoAndPlay(51);
         KTool.doExchange(8017 + this.currType,function():void
         {
         });
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
      
      override protected function init() : void
      {
         super.init();
         getDefinitionByName("com.robot.app2.mapProcess.control.LoongBadgesResonanceController").initMap1158();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.LoongBadgesResonanceController").destroy();
         super.destroy();
      }
   }
}

