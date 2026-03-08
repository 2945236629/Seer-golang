package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
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
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class MapProcess_11765 extends BaseMapProcess
   {
      
      private var m_value:int;
      
      private var num:int;
      
      private var num1:int;
      
      private var num2:int;
      
      private var m_daySpirit:int;
      
      private var bossIndex:int;
      
      private var bossIndex1:int;
      
      private var IsFisrtTime1:Boolean;
      
      private var IsFisrtTime2:Boolean;
      
      private var totalNum:int;
      
      private var hasNum:int;
      
      private var lastPos:Point;
      
      private var objP:Point;
      
      private var objP1:Point;
      
      private var objP2:Point;
      
      private var initPos:Point;
      
      public function MapProcess_11765()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = true;
         this.IsFisrtTime1 = false;
         this.IsFisrtTime2 = false;
         MainManager.actorInfo.mapID = 11765;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick1);
         depthLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.initPos = new Point(219,485);
         this.objP = new Point();
         this.objP1 = new Point();
         this.objP2 = new Point();
         this.objP1.x = 127;
         this.objP1.y = 371;
         this.objP2.x = 582;
         this.objP2.y = 303;
         MainManager.actorModel.pos = this.initPos.clone();
         this.update();
         MainManager.actorModel.addEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
      }
      
      public function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getMultiValue([104641,10575],function(param1:Array):void
         {
            var arr:Array = param1;
            m_value = arr[1] & 0x0F;
            num = arr[1] >> 4;
            m_daySpirit = num & 0x0F;
            num1 = num = arr[1] >> 8;
            bossIndex = num1 & 0x0F;
            num2 = num = arr[1] >> 12;
            bossIndex1 = num2 & 0x0F;
            if(m_daySpirit == 1 && m_value < 3 && IsFisrtTime1 == false)
            {
               IsFisrtTime1 = true;
               NpcDialogNew_1.show(3031,["这些负责看守的精灵非常难缠，我必须确保自己不被它们发现……罢了，我还是在它们发出警报前，直接将它们干掉吧！"],null,null,false,function():void
               {
               });
            }
            else if(m_daySpirit == 2 && m_value < 3 && IsFisrtTime2 == false)
            {
               IsFisrtTime2 = true;
               NpcDialogNew_1.show(3032,["这些负责看守的精灵非常难缠，我必须确保自己不被它们发现……罢了，我还是在它们发出警报前，直接将它们干掉吧！"],null,null,false,function():void
               {
               });
            }
            if(bossIndex == 1)
            {
               depthLevel["item1"]["txtnum1"].text = "免疫物理攻击";
            }
            else
            {
               depthLevel["item1"]["txtnum1"].text = "免疫特殊攻击";
            }
            if(bossIndex1 == 1)
            {
               depthLevel["item2"]["txtnum2"].text = "免疫物理攻击";
            }
            else
            {
               depthLevel["item2"]["txtnum2"].text = "免疫特殊攻击";
            }
            if(m_value <= 1)
            {
               depthLevel["item2"]["daoge2"].mouseEnabled = false;
            }
            if(m_value >= 2)
            {
               depthLevel["item1"].visible = false;
               depthLevel["item2"]["daoge2"].mouseEnabled = true;
            }
            if(m_value >= 3)
            {
               depthLevel["pet"].mouseEnabled = true;
               depthLevel["item2"].visible = false;
               depthLevel["tips"].visible = false;
            }
            else
            {
               depthLevel["pet"].mouseEnabled = false;
            }
            if(m_value >= 4)
            {
               depthLevel["pet"].visible = false;
            }
         });
      }
      
      public function onConClick1(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "door_1":
               MapManager.changeMap(11766);
         }
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "daoge1":
               NpcDialog.show(1210,["你们……留下！"],["准备作战！","用钻石砸晕它！"],[function():void
               {
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                  {
                     FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                  });
                  FightManager.tryFight(923,[0,0,0,0,0]);
                  update();
               },function():void
               {
                  KTool.buyProductByCallback(254933,1,function():void
                  {
                     SocketConnection.sendByQueue(43305,[19,3],function(param1:*):void
                     {
                        update();
                     });
                  });
               },null],false,null,true);
               break;
            case "daoge2":
               NpcDialog.show(1210,["你们……留下！"],["准备作战！","用钻石砸晕它！"],[function():void
               {
                  FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
                  {
                     FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
                  });
                  FightManager.tryFight(924,[0,0,0,0,0]);
                  update();
               },function():void
               {
                  KTool.buyProductByCallback(254933,1,function():void
                  {
                     SocketConnection.sendByQueue(43305,[19,4],function(param1:*):void
                     {
                        update();
                     });
                  });
               },null],false,null,true);
               break;
            case "pet":
               SocketConnection.sendByQueue(43305,[19,5],function(param1:*):void
               {
                  var e:* = param1;
                  if(m_daySpirit == 1)
                  {
                     NpcDialogNew_1.show(3031,["快，跟我走！我们必须趁混沌教派没有反应过来，立刻回到避难所！"],["避难所？"],[function():void
                     {
                        update();
                     }]);
                  }
                  else
                  {
                     NpcDialogNew_1.show(3032,["快，跟我走！我们必须趁混沌教派没有反应过来，立刻回到避难所！"],["避难所？"],[function():void
                     {
                        update();
                     }]);
                  }
               });
         }
      }
      
      public function onWalkEnter(param1:RobotEvent) : void
      {
         var p:Point = null;
         var temp:Number = NaN;
         var temp1:Number = NaN;
         var temp2:Number = NaN;
         var e:RobotEvent = param1;
         p = MainManager.actorModel.pos;
         temp = Point.distance(p,this.objP);
         temp1 = Point.distance(p,this.objP1);
         temp2 = Point.distance(p,this.objP2);
         if(temp1 < 50 && this.m_value < 2)
         {
            NpcDialog.show(1210,["你们……留下！"],["准备作战！","用钻石砸晕它！"],[function():void
            {
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               });
               FightManager.tryFight(923,[0,0,0,0,0]);
               update();
            },function():void
            {
               KTool.buyProductByCallback(254933,1,function():void
               {
                  SocketConnection.sendByQueue(43305,[19,3],function(param1:*):void
                  {
                     update();
                  });
               });
            },null],false,null,true);
         }
         if(temp2 < 50 && this.m_value < 3 && this.m_value == 2)
         {
            NpcDialog.show(1210,["你们……留下！"],["准备作战！","用钻石砸晕它！"],[function():void
            {
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               });
               FightManager.tryFight(924,[0,0,0,0,0]);
               update();
            },function():void
            {
               KTool.buyProductByCallback(254933,1,function():void
               {
                  SocketConnection.sendByQueue(43305,[19,4],function(param1:*):void
                  {
                     update();
                  });
               });
            },null],false,null,true);
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         MainManager.actorModel.removeEventListener(RobotEvent.WALK_ENTER_FRAME,this.onWalkEnter);
         conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick1);
         depthLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         ToolBarController.panel.visible = true;
      }
   }
}

