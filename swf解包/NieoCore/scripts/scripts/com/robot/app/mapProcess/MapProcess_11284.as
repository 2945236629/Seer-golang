package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11284 extends BaseMapProcess
   {
      
      private var ogreArr:Array;
      
      public function MapProcess_11284()
      {
         super();
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            this.ogreArr[_loc1_].removeEventListener(RobotEvent.OGRE_CLICK,this.onClick);
            this.ogreArr[_loc1_].destroy();
            _loc1_++;
         }
         this.ogreArr.length = 0;
         this.ogreArr = null;
         topLevel.removeEventListener(MouseEvent.CLICK,this.onTopClick);
         super.destroy();
      }
      
      override protected function init() : void
      {
         var pointArr:Array;
         var i:int;
         var obj:OgreModel = null;
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         pointArr = [277,386,478,400,686,329];
         this.ogreArr = [];
         i = 0;
         while(i < 3)
         {
            obj = new OgreModel(i);
            obj.addEventListener(RobotEvent.OGRE_CLICK,this.onClick);
            obj.show(53,new Point(pointArr[i * 2],pointArr[i * 2 + 1]));
            this.ogreArr.push(obj);
            i++;
         }
         ItemManager.updateAndGetItemsNum([1710022],function(param1:Array):void
         {
            topLevel["numTxt"].text = param1[0] + "";
         });
         topLevel.addEventListener(MouseEvent.CLICK,this.onTopClick);
      }
      
      private function onTopClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "goBackBtn":
               ModuleManager.showAppModule("PreviousKingOfGroundTask2Panel");
               break;
            case "leftBtn":
               MapManager.changeMapWithCallback(1,function():void
               {
                  ModuleManager.showAppModule("PreviousKingOfGroundTask2Panel");
               });
               break;
            case "plus":
               ModuleManager.showAppModule("MultiBuyPanel",{
                  "productID":248041,
                  "iconID":1710022,
                  "exchangeID":9113,
                  "callFunction":function(param1:int):void
                  {
                     var i:int = param1;
                     ItemManager.updateAndGetItemsNum([1710022],function(param1:Array):void
                     {
                        topLevel["numTxt"].text = param1[0] + "";
                     });
                  }
               });
         }
      }
      
      private function onClick(param1:Event) : void
      {
         StatManager.sendStat2014("0715前代地面系精灵王","进入与莫比的对战","2016运营活动");
         FightManager.fightNoMapBoss("莫比",7451);
      }
   }
}

