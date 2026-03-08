package com.robot.app.mapProcess
{
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_10969 extends BaseMapProcess
   {
      
      private var _npcIsClicked:Boolean = false;
      
      public function MapProcess_10969()
      {
         super();
      }
      
      override protected function init() : void
      {
         getDefinitionByName("com.robot.app2.control.ShipModifyController").initForMap(this);
         (this.conLevel["npc"] as MovieClip).buttonMode = true;
         (this.conLevel["npc"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onClickNpc);
      }
      
      private function onClickNpc(param1:MouseEvent) : void
      {
         if(!this._npcIsClicked)
         {
            this._npcIsClicked = true;
            getDefinitionByName("com.robot.app2.control.ShipModifyController").nextAction();
         }
         else
         {
            ModuleManager.showAppModule("ShipTipsPanel");
         }
      }
      
      override public function destroy() : void
      {
         (this.conLevel["npc"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onClickNpc);
      }
   }
}

