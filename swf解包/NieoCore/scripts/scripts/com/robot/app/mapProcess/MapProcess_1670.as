package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_1670 extends BaseMapProcess
   {
      
      public function MapProcess_1670()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["infoAnim"].visible = false;
         btnLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "infoBtn":
               btnLevel.visible = false;
               conLevel["infoAnim"].visible = true;
               conLevel["infoAnim"].gotoAndPlay(1);
         }
      }
   }
}

