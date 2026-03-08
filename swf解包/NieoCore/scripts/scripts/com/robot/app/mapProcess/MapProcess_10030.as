package com.robot.app.mapProcess
{
   import com.robot.app.darkPortal.DarkKongfuController;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_10030 extends BaseMapProcess
   {
      
      private var _backMC:MovieClip;
      
      public function MapProcess_10030()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initRes();
         Alarm.show("精灵太空站已消失在时空中，请前往全新的贾斯汀太空站！",function():void
         {
            MapManager.changeMap(1147);
         });
      }
      
      override public function destroy() : void
      {
         this.restoreRes();
         animatorLevel.removeEventListener(Event.ENTER_FRAME,this.onEnterHandler);
         DarkKongfuController.destoryPanel();
      }
      
      private function initRes() : void
      {
         this._backMC = conLevel["backMc"];
         ToolTipManager.add(this._backMC,"暗黑武斗场");
         this._backMC.buttonMode = true;
         this._backMC.addEventListener(MouseEvent.CLICK,this.onBackMCClick);
      }
      
      private function onBackMCClick(param1:MouseEvent) : void
      {
         MapManager.changeMap(110);
      }
      
      private function restoreRes() : void
      {
         ToolTipManager.remove(this._backMC);
         this._backMC.removeEventListener(MouseEvent.CLICK,this.onBackMCClick);
         this._backMC = null;
      }
      
      public function onDarkHandler() : void
      {
         DarkKongfuController.getResult(this.onResultHandler);
      }
      
      private function onResultHandler(param1:uint) : void
      {
         if(param1 >= 100)
         {
            animatorLevel.addEventListener(Event.ENTER_FRAME,this.onEnterHandler);
         }
         else
         {
            DarkKongfuController.showPanel();
         }
      }
      
      private function onEnterHandler(param1:Event) : void
      {
         if(animatorLevel["effect0"])
         {
            animatorLevel.removeEventListener(Event.ENTER_FRAME,this.onEnterHandler);
            animatorLevel["effect0"].gotoAndPlay(2);
            (animatorLevel["effect0"] as MovieClip).addFrameScript(animatorLevel["effect0"].totalFrames - 1,this.onPlayEndHandler);
         }
      }
      
      private function onPlayEndHandler() : void
      {
         (animatorLevel["effect0"] as MovieClip).gotoAndStop(animatorLevel["effect0"].totalFrames - 1);
         (animatorLevel["effect0"] as MovieClip).addFrameScript(animatorLevel["effect0"].totalFrames - 1,null);
         DarkKongfuController.showPanel();
      }
   }
}

