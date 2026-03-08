package com.robot.app.mapProcess
{
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_816 extends BaseMapProcess
   {
      
      private var sceneNames:Array = ["烈焰之地","极寒之地","云之仙境"];
      
      public function MapProcess_816()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.initLostTempChoseBtn();
         getDefinitionByName("com.robot.app2.control.LostTempleControl").initForMap816();
         MapListenerManager.add(conLevel["cardIcon"],function():void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("LostTempleTottagePanel"),"..正在打开");
         },"遗失的精灵法典");
         MapListenerManager.add(conLevel["datou"],function():void
         {
            NpcDialog.show(NPC.LINGSHOUZHIZUN,[MainManager.actorInfo.nick + "，现在挑战我还太早了点，先去接受我徒弟们的考验吧！"]);
         });
      }
      
      private function initLostTempChoseBtn() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.addChoseBtnEvent(_loc1_);
            _loc1_++;
         }
      }
      
      private function addChoseBtnEvent(param1:int) : void
      {
         var i:int = param1;
         var btn:DisplayObject = conLevel["guanka" + i];
         MapListenerManager.add(btn as InteractiveObject,function():void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("LostTempleStartPanel"),"..正在打开",i);
         },this.sceneNames[i]);
      }
   }
}

