package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.event.RobotEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alarm2;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11766 extends BaseMapProcess
   {
      
      private var m_Index:int;
      
      private var m_value:int;
      
      private var num:int;
      
      private var m_daySpirit:int;
      
      private var totalNum:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var objP1:Point;
      
      private var initPos:Point;
      
      public function MapProcess_11766()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         MainManager.actorInfo.mapID = 11766;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick1);
         this.initPos = new Point(801,309);
         this.objP = new Point();
         this.objP.x = conLevel["door_0"].x;
         this.objP.y = conLevel["door_0"].y;
         MainManager.actorModel.pos = this.initPos.clone();
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([10575],function(param1:Array):void
         {
            m_value = param1[0] & 0x0F;
            num = param1[0] >> 4;
            m_daySpirit = num & 0x0F;
            if(m_value < 4)
            {
               conLevel["monster"].visible = false;
               conLevel["flag"].visible = false;
               conLevel["door_0"].visible = true;
               conLevel["door_1"].visible = true;
            }
            else
            {
               conLevel["monster"].visible = true;
               conLevel["flag"].visible = true;
               conLevel["door_0"].visible = false;
               conLevel["door_1"].visible = false;
            }
            if(m_value == 4)
            {
               playAnimation();
               conLevel["monster"].visible = true;
               conLevel["flag"].visible = true;
            }
            if(m_value >= 5)
            {
               conLevel["monster"].visible = true;
               conLevel["flag"].visible = true;
               conLevel["tips"].visible = true;
            }
            else
            {
               conLevel["monster"].visible = false;
               conLevel["flag"].visible = false;
               conLevel["tips"].visible = false;
            }
            if(m_value >= 6)
            {
               conLevel["monster"].visible = false;
               conLevel["flag"].visible = false;
               conLevel["tips"].visible = false;
               conLevel["door_0"].visible = true;
            }
         });
      }
      
      private function playAnimation() : void
      {
         SocketConnection.sendByQueue(43305,[19,6],function(param1:*):void
         {
            update();
         });
         if(this.m_daySpirit == 1)
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("MinaVillageUndercurrentS4"),this.stopPlaying1);
         }
         else
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("MinaVillageUndercurrentS5"),this.stopPlaying1);
         }
      }
      
      private function stopPlaying1() : void
      {
         NpcDialogNew_1.show(3034,["哼，你们好大的胆子，敢从我们混沌教派手里抢人！今天，我就要让你们吃不了兜着走！"],null,null,false,function():void
         {
         });
      }
      
      public function onConClick1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var index:int = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "monster":
               NpcDialog.show(2226,["无知的蠢货，既然来了，就别想走了！"],["准备作战！","用钻石砸晕它！","躲闪开来。"],[function():void
               {
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                  {
                     FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                     if(!FightManager.isWin || param1.dataObj.type == 5)
                     {
                        Alarm2.show("你被博卡斯特所击败，任务失败！");
                        MapManager.changeMap(11762);
                     }
                  });
                  if(m_daySpirit == 1)
                  {
                     FightManager.tryFight(927,[0,0,0,0,0]);
                  }
                  else
                  {
                     FightManager.tryFight(928,[0,0,0,0,0]);
                  }
                  update();
               },function():void
               {
                  KTool.buyProductByCallback(254934,1,function():void
                  {
                     SocketConnection.sendByQueue(43305,[19,7],function(param1:*):void
                     {
                        update();
                     });
                  });
               },null],false,null,true);
               break;
            case "door_2":
               MapManager.changeMap(11765);
               break;
            case "door_1":
               MapManager.changeMap(11763);
               break;
            case "door_0":
               MapManager.changeMap(11762);
         }
      }
      
      private function stopPlaying() : void
      {
         SocketConnection.sendByQueue(43305,[19,6],function(param1:*):void
         {
            var e:* = param1;
            NpcDialogNew_1.show(3034,["哼，你们好大的胆子，敢从我们混沌教派手里抢人！今天，我就要让你们吃不了兜着走！"],null,null,false,function():void
            {
               update();
            });
         });
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Number = NaN;
         _loc2_ = MainManager.actorModel.pos;
         _loc3_ = Point.distance(_loc2_,this.objP);
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick1);
         ToolBarController.panel.visible = true;
      }
   }
}

