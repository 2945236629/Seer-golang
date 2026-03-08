package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.OgreModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11681 extends BaseMapProcess
   {
      
      private static var ogres:Array = [];
      
      private static var _bossId:int = 756;
      
      public var showTips:Boolean = false;
      
      public function MapProcess_11681()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         this.addBoss();
         MainManager.actorInfo.mapID = 11681;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.update();
      }
      
      public function addBoss() : void
      {
         var _loc3_:OgreModel = null;
         this.removeBoss();
         ogres = [];
         var _loc1_:Array = [new Point(409,281),new Point(552,372),new Point(414,394),new Point(521,269)];
         var _loc2_:int = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = new OgreModel(_loc2_);
            ogres.push(_loc3_);
            _loc3_.addEventListener(RobotEvent.OGRE_CLICK,this.onClickBossHandler);
            _loc3_.show(_bossId,_loc1_[_loc2_]);
            _loc2_++;
         }
      }
      
      private function removeBoss() : void
      {
         var _loc1_:int = 0;
         var _loc2_:OgreModel = null;
         if(ogres)
         {
            _loc1_ = 0;
            while(_loc1_ < ogres.length)
            {
               _loc2_ = ogres[_loc1_];
               _loc2_.removeEventListener(RobotEvent.OGRE_CLICK,this.onClickBossHandler);
               _loc2_.destroy();
               _loc1_++;
            }
            ogres.splice(0);
         }
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([104434,104432,104438],function(param1:Array):void
         {
            var i:int;
            var arr:Array = param1;
            conLevel["txt_1"].text = int(arr[2]) + "";
            arr[0] = arr[0] >> 12 & 0x0F;
            i = 1;
            while(i <= 4)
            {
               if(KTool.getBit(arr[0],i) == 1)
               {
                  conLevel["btn_" + i].visible = false;
               }
               else
               {
                  conLevel["btn_" + i].visible = true;
               }
               i++;
            }
            if(arr[1] >= 3)
            {
               KTool.changeMapWithCallBack(1,function():void
               {
               });
               return;
            }
            if(arr[0] == 15)
            {
               conLevel["mc"].visible = true;
               if(!showTips)
               {
                  showTips = true;
                  Alarm.show("传承妖珠终于出现了，快把它收好！");
               }
            }
            else
            {
               conLevel["mc"].visible = false;
            }
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "btn_" + index:
               ModuleManager.showAppModule("LandisStrongSub3Panel",index);
               break;
            case "bag":
               ModuleManager.showAppModule("ADPetBagPanelNew");
               break;
            case "cure":
               PetManager.cureAllFree();
               break;
            case "plus":
               KTool.buyProductByCallback(253908,1,function():void
               {
                  SocketConnection.sendWithCallback(43298,update,12,5);
               });
               break;
            case "close":
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("LandisStrongJumpPanel");
               });
               break;
            case "item":
               SocketConnection.sendWithCallback(43298,function():void
               {
                  KTool.changeMapWithCallBack(1,function():void
                  {
                     ModuleManager.showAppModule("LandisStrongJumpPanel");
                  });
               },12,6);
         }
      }
      
      protected function onClickBossHandler(param1:RobotEvent) : void
      {
         var event:RobotEvent = param1;
         FightManager.fightNoMapBoss("邪特",13376,false,true,function():void
         {
            if(FightManager.isWin)
            {
               KTool.getMultiValue([104434],function(param1:Array):void
               {
                  Alarm.show("你获得了" + (param1[0] >> 8 & 0x0F) + "份后天妖气！");
               });
            }
         });
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         if(conLevel != null)
         {
            conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         }
         ToolBarController.panel.visible = true;
         this.removeBoss();
      }
   }
}

