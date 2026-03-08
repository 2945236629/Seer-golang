package com.robot.app.mapProcess
{
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_1151 extends BaseMapProcess
   {
      
      public function MapProcess_1151()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(conLevel["doorBtn1"],"精灵王的试炼");
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         switch(event.target.name)
         {
            case "doorBtn":
               ModuleManager.showAppModule("WheelChoicePanel");
               break;
            case "goMapBtn":
               MapManager.changeMap(1147);
               break;
            case "goMapBtn_1":
               MapManager.changeMapWithCallback(1196,function():void
               {
                  ModuleManager.showAppModule("NewPVEPanel");
               });
               break;
            case "doorBtn1":
               ModuleManager.showAppModule("PveElvenKingTrialMainPanel");
               break;
            case "doorBtn2":
               ModuleManager.showAppModule("EndlessBattleMainPanel");
               break;
            case "battleBtn":
               ModuleManager.showAppModule("NewBattleLaboratoryMainPanel");
         }
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["doorBtn1"]);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
   }
}

