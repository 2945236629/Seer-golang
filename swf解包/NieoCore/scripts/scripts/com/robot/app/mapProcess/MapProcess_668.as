package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.xml.*;
   import com.robot.core.info.userItem.SingleItemInfo;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import com.robot.core.ui.alert.*;
   import com.robot.core.utils.*;
   import com.robot.xin.XinNewBOSS;
   import flash.events.*;
   import flash.geom.*;
   import flash.utils.*;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.*;
   
   public class MapProcess_668 extends BaseMapProcess
   {
      
      private var bossController:XinNewBOSS;
      
      public function MapProcess_668()
      {
         super();
      }
      
      override protected function init() : void
      {
         var map:BaseMapProcess = null;
         map = null;
         map = this;
         this.initBoss();
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         conLevel["arrow"].visible = false;
         conLevel["changeCapsule"].visible = false;
         conLevel["task_706_2"].visible = false;
         conLevel["powerSlotMC"].visible = false;
         conLevel["guideMC746"].visible = false;
         conLevel["pillar"].visible = false;
         conLevel["task705_1"].visible = false;
         conLevel["guide_mc"].visible = false;
         depthLevel["leiyi"].visible = false;
         conLevel["machine"].addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverDoor);
         Task753.initTaskForMap668(this);
         this.intChangeCapsule();
         TasksManager.getProStatusList(753,function(param1:Array):void
         {
            var a:Array = param1;
            if(Boolean(a[0]) && Boolean(a[1]) && !a[2])
            {
               return;
            }
            Task746.initTaskFor668(map);
            TasksManager.getProStatusList(746,function(param1:Array):void
            {
               if(Boolean(param1[4]) && !param1[5])
               {
                  return;
               }
               Task705.initTaskForMap668();
               if(TasksManager.getTaskStatus(705) == TasksManager.ALR_ACCEPT)
               {
                  return;
               }
               Task706.initTaskForMap668(map);
            });
         });
      }
      
      private function onMouseOverDoor(param1:Event) : void
      {
         conLevel["machine"].play();
      }
      
      private function intOre() : void
      {
         conLevel["ore"].buttonMode = true;
         ToolTipManager.add(conLevel["ore"],"异能晶石");
         conLevel["ore"].addEventListener(MouseEvent.CLICK,this.onOreClick);
      }
      
      private function onOreClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         MainManager.actorModel.moveAndAction(new Point(600,250),function():void
         {
            conLevel["powerSlotMC"].visible = true;
            AnimateManager.playMcAnimate(conLevel["powerSlotMC"],1,"",function():void
            {
               conLevel["powerSlotMC"].visible = false;
               SocketConnection.send(CommandID.GATHER_ORE);
            });
         });
      }
      
      private function intChangeCapsule() : void
      {
         conLevel["changeCapsule"].visible = true;
         conLevel["changeCapsule"].buttonMode = true;
         conLevel["changeCapsule"].gotoAndStop(2);
         conLevel["changeCapsule"].addEventListener(MouseEvent.CLICK,this.onblackSeerClick);
         this.intOre();
      }
      
      private function onblackSeerClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         conLevel["changeCapsule"].gotoAndStop(2);
         NpcDialog.show(NPC.JIENI,["咦！小无双，你怎么来异能星啦！找我有事吗？"],["了解异能精灵！","兑换异能胶囊！"],[function():void
         {
            NpcDialog.show(NPC.JIENI,["哦！是关于异能精灵啊！恩….让我来告诉你吧！异能精灵是异能星上极为稀有的精灵种类，它们各有特点，如果你想和它们做朋友并且捕捉的话，那你就一定要有0xff0000异能胶囊0xffffff！"],["异能胶囊？"],[function():void
            {
               var nRet:* = TasksManager.getTaskStatus(708);
               if(nRet == TasksManager.UN_ACCEPT)
               {
                  NpcDialog.show(NPC.JIENI,["是的！我这里正好有一些，先送你一个吧!你可以去试试，如果你有需要每天0xff000014:00—17:000xffffff点我会在这里巡逻！你可以来找我！"],["好的，我知道了！"],[function():void
                  {
                     TasksManager.accept(708,function():void
                     {
                        TasksManager.complete(708,0);
                     });
                  }]);
               }
               else
               {
                  NpcDialog.show(NPC.JIENI,["是的！如果你有需要每天我会在这里巡逻！你可以来找我！"],["好的，我知道了！"]);
               }
            }]);
         },this.changeCapsule]);
      }
      
      private function changeCapsule() : void
      {
         var info:SingleItemInfo = ItemManager.getCollectionInfo(400854);
         var num:int = info ? int(info.itemNum) : 0;
         NpcDialog.show(NPC.JIENI,["小无双，想获得异能胶囊的话一定要有0xff0000异能晶石0xffffff哦！你现在有0xff0000" + num + "0xffffff个0xff0000异能晶石0xffffff，想要兑换多少个异能胶囊呢？"],["10个异能晶石兑换1个异能胶囊！","30个异能晶石兑换5个异能胶囊！","50个异能晶石兑换10个异能胶囊！","让我想想。"],[function():void
         {
            SocketConnection.addCmdListener(CommandID.EXCHANGE_CLOTH_COMPLETE,clostCompLeteHandler);
            SocketConnection.send(CommandID.EXCHANGE_CLOTH_COMPLETE,183);
         },function():void
         {
            SocketConnection.addCmdListener(CommandID.EXCHANGE_CLOTH_COMPLETE,clostCompLeteHandler);
            SocketConnection.send(CommandID.EXCHANGE_CLOTH_COMPLETE,184);
         },function():void
         {
            SocketConnection.addCmdListener(CommandID.EXCHANGE_CLOTH_COMPLETE,clostCompLeteHandler);
            SocketConnection.send(CommandID.EXCHANGE_CLOTH_COMPLETE,185);
         }]);
      }
      
      private function clostCompLeteHandler(param1:SocketEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         SocketConnection.removeCmdListener(CommandID.EXCHANGE_CLOTH_COMPLETE,this.clostCompLeteHandler);
         var _loc4_:ByteArray = param1.data as ByteArray;
         _loc4_.readUnsignedInt();
         _loc4_.readUnsignedInt();
         _loc4_.readUnsignedInt();
         _loc4_.readUnsignedInt();
         _loc4_.readUnsignedInt();
         var _loc5_:uint = _loc4_.readUnsignedInt();
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = _loc4_.readUnsignedInt();
            _loc3_ = _loc4_.readUnsignedInt();
            Alarm.show(_loc3_ + "个" + TextFormatUtil.getRedTxt(ItemXMLInfo.getName(_loc2_)) + "已经放入你的背包。");
            _loc6_++;
         }
      }
      
      override public function destroy() : void
      {
         ToolTipManager.remove(conLevel["ore"]);
         conLevel["ore"].removeEventListener(MouseEvent.CLICK,this.onOreClick);
         conLevel["changeCapsule"].removeEventListener(MouseEvent.CLICK,this.onblackSeerClick);
         conLevel["machine"].removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverDoor);
         Task706.destroy();
         Task746.destroy();
         Task753.destroy();
         this.destroyBoss();
      }
      
      private function initBoss() : void
      {
      }
      
      private function destroyBoss() : void
      {
         this.bossController.destroy();
         this.bossController = null;
      }
   }
}

