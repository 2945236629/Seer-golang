package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcess_1129 extends BaseMapProcess
   {
      
      public function MapProcess_1129()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         this.btnLevel["mcCard"].visible = false;
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            SimpleButton(this.conLevel["btnCard_" + _loc1_]).addEventListener(MouseEvent.CLICK,this.onClickCard);
            _loc1_++;
         }
         btnLevel["mcCard"].addEventListener(MouseEvent.CLICK,this.onClickCardMc);
      }
      
      protected function onClickCard(param1:MouseEvent) : void
      {
         var _loc2_:int = int(String(param1.currentTarget.name).split("_")[1]);
         this.btnLevel["mcCard"].visible = true;
         this.btnLevel["mcCard"].gotoAndStop(_loc2_ + 1);
      }
      
      protected function onClickCardMc(param1:MouseEvent) : void
      {
         this.btnLevel["mcCard"].visible = false;
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            SimpleButton(this.conLevel["btnCard_" + _loc1_]).removeEventListener(MouseEvent.CLICK,this.onClickCard);
            _loc1_++;
         }
         btnLevel["mcCard"].removeEventListener(MouseEvent.CLICK,this.onClickCardMc);
         super.destroy();
      }
   }
}

