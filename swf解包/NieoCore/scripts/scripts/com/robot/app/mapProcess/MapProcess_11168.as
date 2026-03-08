package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alert;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_11168 extends BaseMapProcess
   {
      
      public function MapProcess_11168()
      {
         super();
      }
      
      override protected function init() : void
      {
         var i:int = 0;
         var cls:Class = null;
         var anim:* = undefined;
         if(!BitBuffSetClass.getState(23102))
         {
            btnLevel.visible = false;
            conLevel.visible = false;
            depthLevel.visible = false;
            cls = getDefinitionByName("com.robot.app2.component.PlayAnimationComponent") as Class;
            anim = new cls("LoyaPlaneTreasureAnim",function():void
            {
               btnLevel.visible = true;
               conLevel.visible = true;
               depthLevel.visible = true;
               BitBuffSetClass.setState(23102,1);
               anim.destroy();
            });
         }
         i = 1;
         while(i <= 4)
         {
            btnLevel["btns_" + i].stop();
            btnLevel["btns_" + i].addEventListener(MouseEvent.ROLL_OVER,this.onOver);
            btnLevel["btns_" + i].addEventListener(MouseEvent.ROLL_OUT,this.onOut);
            i++;
         }
         btnLevel.addEventListener(MouseEvent.CLICK,this.onClick);
         this.update();
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var e:MouseEvent = param1;
         index = int(String(e.target.parent.name).split("_")[1]);
         switch(e.target.name)
         {
            case "btn_fight":
               Alert.show("即将进入战斗，你准备好了吗？",function():void
               {
                  fight(index - 1);
               });
               break;
            case "buy_fight":
               KTool.buyProductByCallback(246868,1,function():void
               {
                  KTool.socketSendCallBack(43701,update,[4 + index]);
               });
         }
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(2);
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         param1.currentTarget.gotoAndStop(1);
      }
      
      private function update(param1:* = null) : void
      {
         var e:* = param1;
         KTool.getBitSet([17781,17782,17783,17784],function(param1:Array):void
         {
            var _loc4_:* = false;
            var _loc2_:int = 0;
            var _loc3_:int = 1;
            while(_loc3_ <= 4)
            {
               _loc4_ = param1[_loc3_ - 1] > 0;
               btnLevel["btns_" + _loc3_].mouseEnabled = btnLevel["btns_" + _loc3_].mouseChildren = !_loc4_;
               btnLevel["btns_" + _loc3_].visibel = !_loc4_;
               depthLevel["boss_" + _loc3_].visible = !_loc4_;
               depthLevel["arrow_" + _loc3_].visible = !_loc4_;
               if(_loc4_)
               {
                  _loc2_++;
               }
               _loc3_++;
            }
            if(_loc2_ >= 4)
            {
               playAnim();
            }
         });
      }
      
      private function fight(param1:int) : void
      {
         var _loc2_:int = 6602 + param1;
         FightManager.fightNoMapBoss("",_loc2_);
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ <= 4)
         {
            btnLevel["btns_" + _loc1_].removeEventListener(MouseEvent.ROLL_OVER,this.onOver);
            btnLevel["btns_" + _loc1_].removeEventListener(MouseEvent.ROLL_OUT,this.onOut);
            _loc1_++;
         }
         btnLevel.removeEventListener(MouseEvent.CLICK,this.onClick);
         super.destroy();
      }
      
      private function playAnim() : void
      {
         var playEnd_1:Function = null;
         var playEnd_2:Function = null;
         var cls:Class = null;
         var anim:* = undefined;
         playEnd_1 = function():void
         {
            NpcDialogNew_1.show(NPC.HAIDAO_1,["冤……冤枉啊，英雄！"],null,null,false,function():void
            {
               NpcDialogNew_1.show(NPC.HAIDAO_2,["贾斯汀他是自己走掉的！"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(NPC.SAIXIAOXI,["哼，你们看到贾斯汀站长，会放任他随意离开？"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(NPC.KALULU,["你们究竟把贾斯汀带到哪里去了，再不告诉我们，别怪我们不客气！"],null,null,false,function():void
                     {
                        NpcDialogNew_1.show(NPC.HAIDAO_1,["我说！我说！他去了……流沙迷境……"],null,null,false,function():void
                        {
                           NpcDialogNew_1.show(NPC.KALULU,["流沙迷境？在来洛亚神域之前，罗杰船长跟我们说过，洛亚神域有一种传说中的石头，叫做“流沙之石”，就是出产于流沙迷境的！"],null,null,false,function():void
                           {
                              NpcDialogNew_1.show(NPC.KALULU,["听说这种石头可以实现发现者的一个愿望，贾斯汀站长一定是去找这块石头，想回到赛尔号！"],null,null,false,function():void
                              {
                                 NpcDialogNew_1.show(NPC.SAIXIAOXI,["走，我们也去一探究竟！"],null,null,false,function():void
                                 {
                                    anim.backFun = playEnd_2;
                                    anim.play(3);
                                 });
                              });
                           });
                        });
                     });
                  });
               });
            });
         };
         playEnd_2 = function():void
         {
            BitBuffSetClass.setState(23103,1);
            NpcDialogNew_1.show(NPC.ATIEDA,["哇哦，厉害了！这玩意怎么帮我们找到贾斯汀站长呢？"],null,null,false,function():void
            {
               NpcDialogNew_1.show(NPC.KALULU,["这是一台追踪仪，只要有足够的分析源，它就能据此分析出目标的前进方位！"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(NPC.ATIEDA,["厉害了！我们快在附近找找，有没有什么贾斯汀站长遗留下来的东西吧！"],null,null,false,function():void
                  {
                     anim.destroy();
                     ModuleManager.showAppModule("LoyaPlaneTreasureDigPanel");
                     btnLevel.visible = true;
                     conLevel.visible = true;
                     depthLevel.visible = true;
                  });
               });
            });
         };
         if(!BitBuffSetClass.getState(23103))
         {
            btnLevel.visible = false;
            conLevel.visible = false;
            depthLevel.visible = false;
            cls = getDefinitionByName("com.robot.app2.component.PlayAnimationComponent") as Class;
            anim = new cls("LoyaPlaneTreasureAnim",playEnd_1,2,true,"item","mc",false);
         }
      }
   }
}

