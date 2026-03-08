package com.robot.app.mapProcess
{
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.BufferRecordManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.ui.alert.Alarm2;
   import com.robot.core.utils.CommonUI;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_793 extends BaseMapProcess
   {
      
      private var _map:BaseMapProcess;
      
      public function MapProcess_793()
      {
         super();
      }
      
      override protected function init() : void
      {
         if(BitBuffSetClass.getState(22964) == 0)
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("EffectStronthenFullMovie"),function():void
            {
               BitBuffSetClass.setState(22964,1);
               CommonUI.addYellowArrow(btnLevel,658,117,230);
            });
         }
         SocketConnection.send(1022,86052272);
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         MapListenerManager.add(btnLevel["equipment"],function(param1:MouseEvent):void
         {
            Alarm2.show("活动已结束！");
         },"极限法则");
         MapListenerManager.add(conLevel["exchangeBtn"],function(param1:MouseEvent):void
         {
            ModuleManager.showModule(ClientConfig.getAppModule("LimitRuleExchange"));
         },"梦幻点数兑换");
         MapListenerManager.add(conLevel["fantasyPetWarBtn"],function(param1:MouseEvent):void
         {
            SocketConnection.send(1022,86052528);
            SocketConnection.send(1022,86053847);
            Alarm2.show("活动已结束！");
         },"梦幻精灵大乱斗");
         MapListenerManager.add(conLevel["petEffectBtn"],function(param1:MouseEvent):void
         {
            SocketConnection.send(1022,86052832);
            CommonUI.removeYellowArrow(conLevel["petEffectBtn"]);
            CommonUI.removeYellowArrow(btnLevel);
            ModuleManager.showModule(ClientConfig.getAppModule("PetEffectStrengthenPanel2015"));
         },"梦幻特性强化器");
         MapListenerManager.add(conLevel["RefractiveBtn"],function(param1:MouseEvent):void
         {
            SocketConnection.send(1022,86053200);
            SocketConnection.send(1022,86053846);
            Alarm2.show("活动已结束！");
         },"折光幻阵");
         this._map = this;
         if(BufferRecordManager.getState(MainManager.actorInfo,477))
         {
            DisplayUtil.removeForParent(this._map.conLevel["JustinAndDoctor"]);
         }
         else
         {
            MapListenerManager.add(this._map.conLevel["JustinAndDoctor"],function(param1:MouseEvent):void
            {
               doPrevTask();
            },"贾斯汀和派特博士");
         }
         conLevel["RefractiveBtn"].gotoAndStop(1);
         conLevel["RefractiveBtn"].addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         conLevel["RefractiveBtn"].addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         conLevel["RefractiveBtn"].gotoAndStop(2);
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         conLevel["RefractiveBtn"].gotoAndStop(3);
      }
      
      private function doPrevTask() : void
      {
         AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("active20121207_6"),function():void
         {
            NpcDialog.show(NPC.SEER,["哇！派特博士、贾斯汀站长和英卡洛斯竟然都在这里！"],null,null,false,function():void
            {
               NpcDialog.show(NPC.DOCTOR,[MainManager.actorInfo.formatNick + "，你来了啊！有个好消息告诉你哦！我的精灵研究又有新的发现！"],["博士好厉害，是什么样的发现啊？"],[function():void
               {
                  NpcDialog.show(NPC.DOCTOR,["继精灵可以拥有特性之后，我们发现特性竟然可以通过梦幻宝石进行强化哦！"],null,null,false,function():void
                  {
                     NpcDialog.show(NPC.JUSTIN,["的确是了不起的发现！英卡洛斯的能力也得到了提升呢！" + MainManager.actorInfo.formatNick + "，期待你的精灵也能变得更强哦！"],["一定的！我是最棒的！"],[function():void
                     {
                        AnimateManager.playMcAnimate(_map.conLevel["JustinAndDoctor"],1,"mc",function():void
                        {
                           BufferRecordManager.setState(MainManager.actorInfo,477,true);
                           DisplayUtil.removeForParent(_map.conLevel["JustinAndDoctor"]);
                           CommonUI.addYellowArrow(_map.conLevel["petEffectBtn"],0,0,315);
                        });
                     }]);
                  });
               }]);
            });
         });
      }
      
      override public function destroy() : void
      {
         conLevel["RefractiveBtn"].removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         conLevel["RefractiveBtn"].removeEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this._map = null;
         super.destroy();
      }
   }
}

