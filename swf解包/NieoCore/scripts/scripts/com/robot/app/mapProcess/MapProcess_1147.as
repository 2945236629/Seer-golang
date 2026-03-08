package com.robot.app.mapProcess
{
   import com.robot.app.sceneInteraction.ArenaController;
   import com.robot.app.sys.SysSOManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alert;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ToolTipManager;
   
   public class MapProcess_1147 extends BaseMapProcess
   {
      
      public function MapProcess_1147()
      {
         super();
      }
      
      override protected function init() : void
      {
         ToolTipManager.add(conLevel["btn_door"],"星空擂台");
         ToolTipManager.add(conLevel["wheelDoorBtn"],"功勋体系 全面开启");
         ToolTipManager.add(conLevel["petDoorBtn"],"全新精灵训练基地");
         ToolTipManager.add(conLevel["leftDoor"],"前往太空站资源区");
         ToolTipManager.add(conLevel["rightDoor"],"前往太空站精灵区");
         ToolTipManager.add(conLevel["arenaTouchBtn_3"],"挑战擂台");
         conLevel["arenaTouchBtn_3"].buttonMode = true;
         ArenaController.getInstance().setup(conLevel.getChildByName("arenaMc") as MovieClip);
         conLevel.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         switch(event.target.name)
         {
            case "btn_door":
               Alert.show("新太空站星空擂台暂未开放！是否前往旧版擂台？",function():void
               {
                  MapManager.changeMap(102);
               });
               break;
            case "wheelDoorBtn":
               ModuleManager.showAppModule("MeritSystemOnlineMianPanel");
               break;
            case "petDoorBtn":
               ModuleManager.showAppModule("TrainingCollectionPanel");
               break;
            case "leftDoor":
               MapManager.changeMap(1153);
               break;
            case "midDoor":
               MapManager.changeMap(1155);
               break;
            case "rightDoor":
               MapManager.changeMap(1151);
               break;
            case "petBattleBtn":
               ModuleManager.showAppModule("NewGiftMainPanel");
               break;
            case "arenaTouchBtn_3":
               this.onArenaHit();
         }
      }
      
      public function onArenaHit() : void
      {
         SocketConnection.send(1022,86053860);
         ArenaController.getInstance().strat();
         SysSOManager.freshLastSys(14003);
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         ArenaController.getInstance().figth();
         ArenaController.getInstance().destroy();
         super.destroy();
      }
   }
}

