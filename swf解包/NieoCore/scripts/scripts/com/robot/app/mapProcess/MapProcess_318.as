package com.robot.app.mapProcess
{
   import com.robot.app.fight.*;
   import com.robot.app.task.tc.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.config.xml.*;
   import com.robot.core.event.*;
   import com.robot.core.info.fightInfo.attack.*;
   import com.robot.core.info.pet.PetListInfo;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import com.robot.core.ui.alert.*;
   import com.robot.core.utils.*;
   import flash.display.*;
   import flash.events.*;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.*;
   
   public class MapProcess_318 extends BaseMapProcess
   {
      
      private static var status:uint;
      
      private static var isFight:Boolean;
      
      private static var checkUseItem:Boolean = false;
      
      public function MapProcess_318()
      {
         super();
      }
      
      override protected function init() : void
      {
         var len:uint = 0;
         var i:uint = 0;
         var mc:MovieClip = null;
         var b:Boolean = false;
         var pet:Array = null;
         var info:PetListInfo = null;
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         ToolTipManager.add(conLevel["pet_0_0"],"德拉萨");
         ToolTipManager.add(conLevel["pet_0_1"],"卡修斯");
         ToolTipManager.add(conLevel["pet_0_2"],"迪符特");
         ToolTipManager.add(conLevel["pet_1_0"],"愤怒之影");
         ToolTipManager.add(conLevel["pet_1_1"],"光芒之影");
         ToolTipManager.add(conLevel["pet_1_2"],"重生之影");
         ToolTipManager.add(conLevel["pet_2"],"菲尼克斯");
         len = uint(conLevel.numChildren);
         i = 0;
         while(i < len)
         {
            mc = conLevel.getChildAt(i) as MovieClip;
            mc.visible = false;
            mc.buttonMode = true;
            mc.addEventListener(MouseEvent.CLICK,this.onPetClick);
            i++;
         }
         EventManager.addEventListener("Error11075",this.onEError11075);
         EventManager.addEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onError);
         EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
         if(!isFight)
         {
            b = false;
            pet = PetManager.getBagMap();
            for each(info in pet)
            {
               if(info.id == 856 || info.id == 857 || info.id == 858)
               {
                  b = true;
               }
            }
            if(b)
            {
               status = 1;
               AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("zhuqueHeti"),function():void
               {
                  initBoss();
               },false);
            }
            else
            {
               status = 0;
               this.initBoss();
            }
         }
      }
      
      private function initBoss() : void
      {
         animatorLevel["small"].visible = false;
         animatorLevel["big"].visible = false;
         switch(status)
         {
            case 0:
               animatorLevel["small"].visible = true;
               animatorLevel["big"].visible = true;
               AnimateManager.playMcAnimate(animatorLevel["small"],1,"mc",function():void
               {
                  conLevel["pet_0_0"].visible = true;
                  conLevel["pet_0_1"].visible = true;
                  conLevel["pet_0_2"].visible = true;
                  conLevel["pet_2"].visible = true;
               });
               break;
            case 1:
               animatorLevel["big"].visible = true;
               AnimateManager.playMcAnimate(animatorLevel["big"],2,"mc_2",function():void
               {
                  conLevel["pet_1_0"].visible = true;
                  conLevel["pet_1_1"].visible = true;
                  conLevel["pet_1_2"].visible = true;
                  conLevel["pet_2"].visible = true;
               });
               break;
            case 2:
               animatorLevel["big"].visible = true;
               AnimateManager.playMcAnimate(animatorLevel["big"],3,"mc_3",function():void
               {
                  conLevel["pet_2"].visible = true;
               });
         }
      }
      
      private function onPetClick(param1:MouseEvent) : void
      {
         switch(status)
         {
            case 0:
               this.startFight_0();
               break;
            case 1:
               this.startFight_1();
               break;
            case 2:
               this.startFight_2();
         }
      }
      
      private function startFight_0() : void
      {
         NpcDialog.show(NPC.ZHUQUE,["我是裂空星系的守护神，你能进到这里说明你已经是个能独挡一面的精英了，但是真正的挑战现在才开始。"],["不管什么挑战我都不怕。","我还是下次再来吧。"],[function():void
         {
            isFight = true;
            FightManager.fightWithBoss("朱雀守护兽",0,true);
         },function():void
         {
            leaveMap();
         }]);
      }
      
      private function checkFightSymbol() : void
      {
         ItemManager.upDateCollection(1700253,function():void
         {
            if(ItemManager.getNumByID(1700253) > 0)
            {
               checkUseItem = true;
               status = 3;
               SocketConnection.sendWithCallback(46050,function(param1:SocketEvent):void
               {
                  FightManager.fightWithBoss("菲尼克斯",2,true);
               },4);
            }
            else
            {
               Alarm.show("你还没有朱雀战符！");
            }
         });
      }
      
      private function startFight_1() : void
      {
         NpcDialog.show(NPC.ZHUQUE,["如果你能击败我的3个分身，那我就认可你的实力，你敢接受这次挑战吗？"],["不管什么挑战我都不怕。","我还是下次再来吧。"],[function():void
         {
            isFight = true;
            FightManager.fightWithBoss("菲尼克斯之影",1,true);
         },function():void
         {
            leaveMap();
         }]);
      }
      
      private function startFight_2() : void
      {
         NpcDialog.show(NPC.ZHUQUE,["你的表现令我震惊，你愿意接受最后的考验吗？"],["不管什么挑战我都不怕。","我还是下次再来吧。"],[function():void
         {
            isFight = true;
            FightManager.fightWithBoss("菲尼克斯",2,true);
         },function():void
         {
            leaveMap();
         }]);
      }
      
      private function onEError11075(param1:RobotEvent) : void
      {
         var e:RobotEvent = param1;
         NpcDialog.show(NPC.ZHUQUE,["朱雀空间出现了异常状况，你必须立刻离开这里。"],["嗯，我知道啦~~"],[function():void
         {
            leaveMap();
         }]);
      }
      
      private function onError(param1:RobotEvent) : void
      {
         isFight = false;
      }
      
      private function onFightOver(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         var info:FightOverInfo = e.dataObj as FightOverInfo;
         if(info.winnerID == MainManager.actorID)
         {
            ++status;
            if(status < 3 && checkUseItem == false)
            {
               this.initBoss();
            }
            else if(TaskClass_148.spriteID != -1)
            {
               NpcDialog.show(NPC.ZHUQUE,["我为你感到骄傲！请收下我的精元，我将与你同在！"],["我不会让你失望的。"],[function():void
               {
                  ItemInBagAlert.show(TaskClass_148.spriteID,"1个" + TextFormatUtil.getRedTxt(ItemXMLInfo.getName(TaskClass_148.spriteID)) + "已经放入你的储存箱！",function():void
                  {
                     leaveMap();
                  });
               }]);
            }
            else
            {
               this.leaveMap();
            }
         }
         else
         {
            NpcDialog.show(NPC.ZHUQUE,["等你的实力有长足的进步时再来吧！"],["我还是下次再来吧。"],[function():void
            {
               leaveMap();
            }]);
         }
      }
      
      private function leaveMap() : void
      {
         status = 0;
         isFight = false;
         MapManager.changeMap(1);
      }
      
      override public function destroy() : void
      {
         var _loc1_:MovieClip = null;
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.show();
         ToolBarController.showOrHideAllUser(true);
         ToolTipManager.remove(conLevel["pet_0_0"]);
         ToolTipManager.remove(conLevel["pet_0_1"]);
         ToolTipManager.remove(conLevel["pet_0_2"]);
         ToolTipManager.remove(conLevel["pet_1_0"]);
         ToolTipManager.remove(conLevel["pet_1_1"]);
         ToolTipManager.remove(conLevel["pet_1_2"]);
         ToolTipManager.remove(conLevel["pet_2"]);
         var _loc2_:uint = uint(conLevel.numChildren);
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = conLevel.getChildAt(_loc3_) as MovieClip;
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onPetClick);
            _loc3_++;
         }
         EventManager.removeEventListener("Error11075",this.onEError11075);
         EventManager.removeEventListener(RobotEvent.NO_PET_CAN_FIGHT,this.onError);
         EventManager.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightOver);
      }
   }
}

