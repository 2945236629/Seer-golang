package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcess_1200 extends BaseMapProcess
   {
      
      private var endtime:int;
      
      protected var maxnum:int;
      
      protected var itemnum:int;
      
      private var inited:Boolean;
      
      public function MapProcess_1200()
      {
         super();
      }
      
      private static function frameHandle(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.gotoAndStop(1);
         }
      }
      
      override protected function init() : void
      {
         this.maxnum = 30;
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         SystemTimerManager.addTickFun(this.timerHandle);
         topLevel["leave"].addEventListener(MouseEvent.CLICK,this.clickHandle);
         topLevel["mc"]["tip"].gotoAndStop(1);
         topLevel["mc"]["tip"].visible = false;
         topLevel["mc"]["tip"].addEventListener(Event.ENTER_FRAME,frameHandle);
         this.updateTime();
      }
      
      private function clickHandle(param1:MouseEvent) : void
      {
         MapManager.changeMap(1202);
      }
      
      private function updateTime() : void
      {
         KTool.getMultiValue([102048,13901],function(param1:Array):void
         {
            if(param1[1] > itemnum && inited)
            {
               topLevel["mc"]["tip"].visible = true;
               topLevel["mc"]["tip"].gotoAndPlay(1);
            }
            if(!inited)
            {
               inited = true;
            }
            itemnum = param1[1];
            endtime = param1[0];
            topLevel["numTxt"].text = param1[1] + "/" + maxnum;
            if(param1[1] >= maxnum)
            {
               SystemTimerManager.removeTickFun(timerHandle);
               topLevel["mc"].visible = false;
            }
            else
            {
               topLevel["mc"].visible = true;
            }
         });
      }
      
      protected function timerHandle() : void
      {
         if(this.endtime <= 0)
         {
            return;
         }
         var _loc1_:int = int(SystemTimerManager.time);
         var _loc2_:int = this.endtime - _loc1_;
         if(_loc1_ >= this.endtime)
         {
            this.updateTime();
         }
         KTool.showScore(topLevel["mc"]["sec"],_loc2_);
      }
      
      override public function destroy() : void
      {
         topLevel["mc"]["tip"].removeEventListener(Event.ENTER_FRAME,frameHandle);
         topLevel["leave"].removeEventListener(MouseEvent.CLICK,this.clickHandle);
         SystemTimerManager.removeTickFun(this.timerHandle);
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         super.destroy();
      }
   }
}

