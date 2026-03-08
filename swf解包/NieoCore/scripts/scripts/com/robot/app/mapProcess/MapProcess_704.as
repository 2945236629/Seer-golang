package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task899;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_704 extends BaseMapProcess
   {
      
      public function MapProcess_704()
      {
         super();
      }
      
      override protected function init() : void
      {
         (MapManager.currentMap.root["effect"] as MovieClip).mouseChildren = false;
         (MapManager.currentMap.root["effect"] as MovieClip).mouseEnabled = false;
         Task899.initForMap704(this);
         getDefinitionByName("com.robot.app2.mapProcess.control.StoneTowerExploreController").initForMap704(this);
      }
      
      private function onChangeClick(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("OldStelePanel"),"正在打开熔炼炉....");
      }
      
      private function onNpcClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(NPC.LALIENI,["熔岩大地中的大熔炉可是提炼0xff0000石碑之魂0xffffff的唯一途径，如果你拥有0xff0000石之魂魄0xffffff的话就放入大熔炉中试试吧！啊哈哈哈！"],["石之魂魄我已经收集到了，开始提炼！","我先去收集石之魂魄！"],[function():void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("OldStelePanel"),"正在打开熔炼炉....");
         }]);
      }
      
      public function goto_702() : void
      {
         MapManager.changeMap(702);
      }
      
      public function goto_705() : void
      {
         MapManager.changeMap(705);
      }
      
      override public function destroy() : void
      {
         Task899.destroy();
         getDefinitionByName("com.robot.app2.mapProcess.control.StoneTowerExploreController").destroyForMap704();
      }
   }
}

