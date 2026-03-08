package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11757 extends BaseMapProcess
   {
      
      private var totalNum:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var initPos:Point;
      
      private var hasRemove:Boolean;
      
      public function MapProcess_11757()
      {
         super();
         StatManager.sendStat2014("1123感恩节庆祝盛典","进入打怪场景","2018运营活动");
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         MainManager.actorInfo.mapID = 11757;
         depthLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.lastPos = MainManager.actorModel.pos.clone();
         this.initPos = new Point(467,495);
         this.objP = new Point();
         this.objP.x = conLevel["obj"].x;
         this.objP.y = conLevel["obj"].y;
         conLevel["obj"].mouseEnabled = conLevel["obj"].mouseChildren = false;
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([104636],function(param1:Array):void
         {
            hasNum = param1[0] & 0x0F;
            totalNum = param1[0] >> 4;
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(e.target.name == "close")
         {
            KTool.changeMapWithCallBack(1,function():void
            {
               ModuleManager.showAppModule("ThanksGiverWishWallMainPanel");
            });
         }
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
         var p:Point = null;
         var temp:Number = NaN;
         var e:RobotEvent = param1;
         p = MainManager.actorModel.pos;
         temp = Point.distance(p,this.lastPos);
         if(temp >= 30 && this.totalNum > this.hasNum)
         {
            if(Math.random() <= (this.totalNum - this.hasNum + 0.2) * temp / Point.distance(this.lastPos,this.objP))
            {
               MainManager.actorModel.stop();
               StatManager.sendStat2014("1123感恩节庆祝盛典","触发战斗","2018运营活动");
               FightManager.fightNoMapBoss("",14715,false,true,function():void
               {
                  if(!FightManager.isWin)
                  {
                     MainManager.actorModel.pos = initPos.clone();
                     MapManager.currentMap.depthLevel.addChild(MainManager.actorModel);
                  }
               });
               this.lastPos = MainManager.actorModel.pos.clone();
               return;
            }
            this.lastPos = MainManager.actorModel.pos.clone();
         }
         temp = Point.distance(p,this.objP);
         if(temp < 30)
         {
            if(this.totalNum > this.hasNum)
            {
               StatManager.sendStat2014("1123感恩节庆祝盛典","触发战斗","2018运营活动");
               FightManager.fightNoMapBoss("",14715,false,true,function():void
               {
                  if(!FightManager.isWin)
                  {
                     MainManager.actorModel.pos = initPos.clone();
                     MapManager.currentMap.depthLevel.addChild(MainManager.actorModel);
                  }
               });
               this.lastPos = MainManager.actorModel.pos.clone();
               return;
            }
            this.hasRemove = true;
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
            SocketConnection.sendWithPromise(43305,[11,3]).then(function():void
            {
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("ThanksGiverWishWallSub3Panel");
               });
            });
            return;
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         if(!this.hasRemove)
         {
            MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         }
         depthLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         ToolBarController.panel.visible = true;
      }
   }
}

