package com.robot.app.mapProcess
{
   import com.robot.core.aimat.AimatController;
   import com.robot.core.event.AimatEvent;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.geom.Point;
   
   public class MapProcess_1531 extends BaseMapProcess
   {
      
      private static var broken:Boolean = false;
      
      public function MapProcess_1531()
      {
         super();
      }
      
      override protected function init() : void
      {
         broken = false;
         AimatController.addEventListener(AimatEvent.PLAY_END,this.onAimatEventPlayEnd);
         animatorLevel["playMc"].visible = false;
         animatorLevel["playMc"].gotoAndStop(1);
      }
      
      private function onAimatEventPlayEnd(param1:AimatEvent) : void
      {
         var _loc2_:Point = null;
         if(broken)
         {
            return;
         }
         if(param1.info.id == 10000)
         {
            _loc2_ = param1.info.endPos;
            if(_loc2_.x >= 329 && _loc2_.x <= 424 && _loc2_.y >= 127 && _loc2_.y <= 213)
            {
               broken = true;
               animatorLevel["playMc"].visible = true;
               animatorLevel["playMc"].gotoAndPlay(1);
            }
         }
      }
      
      override public function destroy() : void
      {
         AimatController.removeEventListener(AimatEvent.PLAY_END,this.onAimatEventPlayEnd);
      }
   }
}

