package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.utils.Direction;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import gs.TweenLite;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_10556 extends BaseMapProcess
   {
      
      private static var bossmov:MovieClip;
      
      private static var petmov:MovieClip;
      
      private static var road:MovieClip;
      
      private static var bag:SimpleButton;
      
      private static var leave:SimpleButton;
      
      public static var bossindex:int;
      
      private static var iswin:Boolean = false;
      
      private const Bossids:Array = [2213,2214,2215,2216,2217,2218,2219,2220,2221,2222,2223,2224,2225,2226,2227];
      
      private const Petids:Array = [259,1872,1851,465,1027,1837,2142,1265,1850,1968,987,2402,1835,1927,2001];
      
      public function MapProcess_10556()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         if(MapManager.prevMapID != 10556)
         {
            bossindex = 0;
         }
         bossmov = MapManager.currentMap.controlLevel["BossMov"];
         bossmov.buttonMode = true;
         road = MapManager.currentMap.controlLevel["Road"];
         MainManager.actorModel.x = 200;
         MainManager.actorModel.y = 150;
         bag = MapManager.currentMap.controlLevel["bag"];
         leave = MapManager.currentMap.controlLevel["leave"];
         bossmov.addEventListener(MouseEvent.CLICK,this.onBattleHandle);
         bag.addEventListener(MouseEvent.CLICK,this.onbaghandel);
         leave.addEventListener(MouseEvent.CLICK,this.onleaveHandle);
         this.updata();
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
      }
      
      private function onleaveHandle(param1:MouseEvent) : void
      {
         MapManager.changeMap(1020);
      }
      
      private function onbaghandel(param1:MouseEvent) : void
      {
         PetBagControllerNew.showByBuffer();
      }
      
      private function onBattleHandle(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(FightManager.currentBossRegion == Bossids[bossindex])
            {
               iswin = (param1.dataObj as FightOverInfo).winnerID == MainManager.actorID;
               if(iswin)
               {
                  ++bossindex;
                  if(bossindex < 15)
                  {
                     updata();
                     moveRoad();
                  }
                  else
                  {
                     MapManager.changeMap(1020);
                     Alarm.show("恭喜你通关了!");
                  }
               }
               else
               {
                  MapManager.changeMap(1020);
               }
            }
         });
         FightManager.fightNoMapBoss("",this.Bossids[bossindex]);
      }
      
      private function loadPet() : void
      {
         ResourceManager.getResource(ClientConfig.getPetFightPath(this.Petids[bossindex]),function(param1:MovieClip):void
         {
            if(petmov != null)
            {
               petmov.parent.removeChild(petmov);
            }
            petmov = param1;
            petmov.scaleX = -1;
            bossmov.addChild(petmov);
         },"pet");
      }
      
      private function moveRoad() : void
      {
         bossmov.visible = false;
         MainManager.actorModel.direction = Direction.RIGHT_DOWN;
         MainManager.actorModel.skeleton.play();
         TweenLite.to(road,5,{
            "x":-1373,
            "y":-290,
            "onComplete":function():void
            {
               bossmov.visible = true;
               MainManager.actorModel.skeleton.stop();
            }
         });
      }
      
      public function requestUpdata() : void
      {
         KTool.getMultiValue([16182,16181],this.updata);
      }
      
      public function updata() : void
      {
         if(bossindex < 15)
         {
            this.loadPet();
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         bossmov.removeEventListener(MouseEvent.CLICK,this.onBattleHandle);
         bag.removeEventListener(MouseEvent.CLICK,this.onbaghandel);
         leave.removeEventListener(MouseEvent.CLICK,this.onleaveHandle);
         super.destroy();
      }
   }
}

