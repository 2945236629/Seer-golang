package com.robot.app.mapProcess
{
   import com.robot.app.ac.PetFightTest;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_1155 extends BaseMapProcess
   {
      
      public function MapProcess_1155()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(conLevel["goBtn_1"],"巅峰圣战");
         ToolTipManager.add(conLevel["goBtn_4"],"资源副本");
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "goBtn_0":
               ModuleManager.showAppModule("GoblinKingBattleRedoPanel");
               break;
            case "goBtn_1":
               MapManager.changeMap(1095);
               break;
            case "goBtn_2":
               PetFightTest.getDate();
               break;
            case "goBtn_3":
               MapManager.changeMap(1147);
               break;
            case "goBtn_4":
               ModuleManager.showAppModule("ResourceCopyMainPanel");
         }
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["goBtn_1"]);
         ToolTipManager.remove(conLevel["goBtn_4"]);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

