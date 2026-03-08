package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_691 extends BaseMapProcess
   {
      
      public function MapProcess_691()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         this.setVisible();
         conLevel["poster"].buttonMode = true;
         conLevel["poster"].addEventListener(MouseEvent.CLICK,this.onClickPoster);
         ToolTipManager.add(conLevel["poster"],"雪藏石碑");
         Task814.initFor691(this);
      }
      
      private function onClickPoster(param1:Event) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("SiNuoActivity"),"正在加载...");
      }
      
      private function setVisible() : void
      {
         conLevel["activity"].visible = false;
         conLevel["monster"].visible = false;
         animatorLevel["blood"].visible = false;
         conLevel["snowFlake"].visible = false;
         conLevel["bury"].visible = false;
         btnLevel["barrier"].visible = false;
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            conLevel["smallBall" + _loc1_].visible = false;
            _loc1_++;
         }
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["poster"]);
         Task814.destroy();
         super.destroy();
      }
   }
}

