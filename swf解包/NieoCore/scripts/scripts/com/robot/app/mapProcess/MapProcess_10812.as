package com.robot.app.mapProcess
{
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   
   public class MapProcess_10812 extends BaseMapProcess
   {
      
      public function MapProcess_10812()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["mc_mov"].visible = false;
         conLevel["mc_npc"].visible = false;
         if(BitBuffSetClass.getState(22651))
         {
            this.initNpc();
         }
         else
         {
            BitBuffSetClass.setState(22651,1);
            conLevel["mc_mov"].visible = true;
            LevelManager.iconLevel.visible = false;
            AnimateManager.playMcAnimate(conLevel["mc_mov"],0,"",function():void
            {
               LevelManager.iconLevel.visible = true;
               conLevel["mc_mov"].visible = false;
               initNpc();
            });
         }
      }
      
      override public function destroy() : void
      {
         conLevel["mc_npc"]["mc_bai"].removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function initNpc() : void
      {
         conLevel["mc_npc"].visible = true;
         conLevel["mc_npc"]["mc_bai"].buttonMode = true;
         conLevel["mc_npc"]["mc_bai"].addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("CutePetTigerGetPanel");
      }
   }
}

