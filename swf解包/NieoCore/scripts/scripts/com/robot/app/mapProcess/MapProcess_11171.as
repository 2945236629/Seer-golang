package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.manager.ResourceManager;
   
   public class MapProcess_11171 extends BaseMapProcess
   {
      
      private var state1:Array = [0,0,0,0,0];
      
      private var state2:Array = [0,0,0,0];
      
      private var state3:Array = [0,0,0,0,0,0,0,0];
      
      private var talkid:int;
      
      private var scenemc1:MovieClip;
      
      private var scenemc2:MovieClip;
      
      private var scenemc3:MovieClip;
      
      private var moviemc:MovieClip;
      
      public function MapProcess_11171()
      {
         super();
      }
      
      private function update() : void
      {
         KTool.getMultiValue([3845,3846,3847],function(param1:Array):void
         {
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:int = 0;
            var _loc2_:Boolean = true;
            var _loc3_:Boolean = true;
            var _loc4_:Boolean = true;
            state1 = [];
            state2 = [];
            state3 = [];
            _loc5_ = 0;
            while(_loc5_ < 5)
            {
               state1.push(KTool.getBit(param1[0],_loc5_ + 1));
               if(KTool.getBit(param1[0],_loc5_ + 1) == 0)
               {
                  _loc2_ = false;
               }
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               _loc6_ = 0;
               _loc7_ = 0;
               while(_loc7_ < 8)
               {
                  _loc6_ += KTool.getBit(param1[1],_loc5_ * 8 + _loc7_ + 1) * Math.pow(2,_loc7_);
                  _loc7_++;
               }
               if(_loc6_ < 2)
               {
                  _loc3_ = false;
               }
               state2.push(_loc6_);
               _loc5_++;
            }
            _loc5_ = 0;
            while(_loc5_ < 8)
            {
               if(KTool.getBit(param1[2],_loc5_ + 1) == 0)
               {
                  _loc4_ = false;
               }
               state3.push(KTool.getBit(param1[2],_loc5_ + 1));
               _loc5_++;
            }
            if(_loc4_)
            {
               if(BitBuffSetClass.getState(23113) == 0)
               {
                  talkid = 28;
                  playmapMovie(8,showTalk);
               }
            }
            else if(_loc3_)
            {
               if(BitBuffSetClass.getState(23110))
               {
                  showLastHaidao();
               }
               else
               {
                  talkid = 17;
                  showTalk();
               }
            }
            else if(_loc2_)
            {
               if(BitBuffSetClass.getState(23111))
               {
                  showFuwen();
               }
               else
               {
                  talkid = 11;
                  showTalk();
               }
            }
            else if(BitBuffSetClass.getState(23109))
            {
               if(BitBuffSetClass.getState(23110))
               {
                  showHaidao();
               }
               else
               {
                  talkid = 7;
                  playmapMovie(3,showTalk);
               }
            }
            else
            {
               talkid = 0;
               playmapMovie(1,showTalk);
            }
         });
      }
      
      override protected function init() : void
      {
      }
      
      private function showTalk() : void
      {
         ++this.talkid;
         switch(this.talkid)
         {
            case 1:
               StatManager.sendStat2014("0311能源精灵的危机","开始前置剧情","2016运营活动");
               NpcDialog.show(NPC.ATIEDA,["哎呀！我的老胳膊老腿啊！要断掉啦！"],null,null,false,this.showTalk);
               break;
            case 2:
               NpcDialog.show(NPC.KALULU,["快起来！我一个女孩子都没喊累！我们必须赶快找到贾斯汀站长！"],null,null,false,this.showTalk);
               break;
            case 3:
               NpcDialog.show(NPC.SAIXIAOXI,["我们在这里人生地不熟的，这么找下去不是个办法啊。我觉得我们需要找一个熟悉这里的人，给我们指引方向。"],null,null,false,this.showTalk);
               break;
            case 4:
               NpcDialog.show(NPC.KALULU,["说的有道理，说不定他还见过贾斯汀站长呢！"],null,null,false,function():void
               {
                  playmapMovie(2,showTalk);
               });
               break;
            case 5:
               NpcDialog.show(NPC.ATIEDA,["咦？什么声音？"],null,null,false,this.showTalk);
               break;
            case 6:
               NpcDialog.show(NPC.SAIXIAOXI,["好像有人在喊救命？"],null,null,false,this.showTalk);
               break;
            case 7:
               NpcDialog.show(NPC.KALULU,["哎呀，一定是遇到了坏人！我们快去看看！"],["走！"],[function():void
               {
                  BitBuffSetClass.setState(23109,1);
                  playmapMovie(3,showTalk);
                  StatManager.sendStat2014("0311能源精灵的危机","前置剧情结束","2016运营活动");
               }],false);
               break;
            case 8:
               NpcDialog.show(NPC.ATIEDA,["又是海盗！这几天我们接连遇到小股的海盗部队，看来海盗们在洛亚神域也非常活跃啊！"],null,null,false,this.showTalk);
               break;
            case 9:
               NpcDialog.show(NPC.SAIXIAOXI,["这是件好事，说明我们距离贾斯汀站长越来越近了。"],null,null,false,this.showTalk);
               break;
            case 10:
               NpcDialog.show(NPC.KALULU,["不过当务之急还是赶紧救下这只精灵吧！你们看它很痛苦的样子，海盗们一定在折磨它！"],null,null,false,this.showTalk);
               break;
            case 11:
               NpcDialog.show(NPC.ATIEDA,["好嘞，一切都交给我！"],["准备战斗！"],[function():void
               {
                  BitBuffSetClass.setState(23110,1);
                  showHaidao();
               }],false);
               break;
            case 12:
               NpcDialog.show(NPC.ANNUO,["呜呜呜……多谢勇士！我可不想再做充电宝了呜呜呜……"],null,null,false,this.showTalk);
               break;
            case 13:
               NpcDialog.show(NPC.SAIXIAOXI,["你好，小精灵。发生了什么事？"],null,null,false,this.showTalk);
               break;
            case 14:
               NpcDialog.show(NPC.ANNUO,["你好，我叫安诺。我们一族有一个特点，就是在游动时身体会自动产生电能。这些坏人看到我们的能力，就把我们都抓了起来，当做充电宝使用，呜呜呜……"],null,null,false,this.showTalk);
               break;
            case 15:
               NpcDialog.show(NPC.ANNUO,["这些日子，我真是生不如死啊，还好你们把我救了……呃，你们能帮忙把束缚我的符文锁链解开吗？"],null,null,false,this.showTalk);
               break;
            case 16:
               NpcDialog.show(NPC.KALULU,["嗨呀，你们两个，光跟别人聊天，倒是先把它身上的锁链解开呀！"],null,null,false,this.showTalk);
               break;
            case 17:
               NpcDialog.show(NPC.ATIEDA,["抱歉抱歉！我们这就帮你解开！"],["谢谢你们！"],[function():void
               {
                  BitBuffSetClass.setState(23111,1);
                  showFuwen();
               }],false);
               break;
            case 18:
               NpcDialog.show(NPC.ANNUO,["天哪，自由！我终于重新获得了自由！"],null,null,false,this.showTalk);
               break;
            case 19:
               NpcDialog.show(NPC.ANNUO,["谢谢你们！我们快回去吧，我已经……"],null,null,false,function():void
               {
                  removefuwenEvent();
                  playmapMovie(6,showTalk);
               });
               break;
            case 20:
               NpcDialog.show(NPC.ANHEIJUSTIN,["嗯？怎么我才离开了一会儿，你们就被一锅端了？真是一群废物！"],null,null,false,this.showTalk);
               break;
            case 21:
               NpcDialog.show(NPC.ANNUO,["是他！大魔王！天啊他回来了！完了，死定了，死定了……"],null,null,false,this.showTalk);
               break;
            case 22:
               NpcDialog.show(NPC.ANNUO,["快跑吧，朋友们，你们不是他的对手，不要管我了！"],null,null,false,this.showTalk);
               break;
            case 23:
               NpcDialog.show(NPC.ATIEDA,["这个人，看起来像是贾斯汀站长，但是却是一名海盗……我明白了！"],null,null,false,this.showTalk);
               break;
            case 24:
               NpcDialog.show(NPC.SAIXIAOXI,["原来之前我们看到的“贾斯汀站长”就是他！难怪他之前跟海盗们在一起，却从容地离开了！"],null,null,false,this.showTalk);
               break;
            case 25:
               NpcDialog.show(NPC.KALULU,["贾斯汀站长……不会已经被海盗们……"],null,null,false,this.showTalk);
               break;
            case 26:
               NpcDialog.show(NPC.SAIXIAOXI,["不！你不要乱想！"],null,null,false,this.showTalk);
               break;
            case 27:
               NpcDialog.show(NPC.ATIEDA,["依我看，先把他拿下，一切自然就水落石出了。"],null,null,false,this.showTalk);
               break;
            case 28:
               NpcDialog.show(NPC.ANHEIJUSTIN,["哼，你们居然还有心情扯东扯西。现在，我就让你们明白，你们的所作所为是要付出代价的！"],null,null,false,function():void
               {
                  playmapMovie(7,function():void
                  {
                     showLastHaidao();
                  });
               });
               break;
            case 29:
               NpcDialog.show(NPC.ATIEDA,["哼，不过是外强中干嘛，就这么跑了！"],null,null,false,this.showTalk);
               break;
            case 30:
               NpcDialog.show(NPC.KALULU,["别骄傲了，我们现在没有了飞船的保护，其实是非常危险的。今天我们只遇到了一小队海盗，万一以后遇到的多了，该怎么办呀。"],null,null,false,this.showTalk);
               break;
            case 31:
               NpcDialog.show(NPC.SAIXIAOXI,["这也不是关键，重要的是，海盗们一定对贾斯汀站长做过什么事情，才造出了全新的“海盗贾斯汀”！"],null,null,false,this.showTalk);
               break;
            case 32:
               NpcDialog.show(NPC.KALULU,["这太可怕了，我们需要赶紧通知罗杰船长！"],null,null,false,this.showTalk);
               break;
            case 33:
               NpcDialog.show(NPC.KALULU,["安诺，你待在这里太不安全了，不如你跟我们一起走吧！等我们回到赛尔号飞船，我们就帮你安置一个新家！"],null,null,false,this.showTalk);
               break;
            case 34:
               NpcDialog.show(NPC.ANNUO,["嗯嗯，谢谢你们！"],["我们走！"],[function():void
               {
                  BitBuffSetClass.setState(23113,1);
                  removeMoviemc();
                  ModuleManager.showAppModule("EnergycrisisPanel");
               }],false);
         }
      }
      
      private function showHaidao() : void
      {
         this.removeMoviemc();
         if(this.scenemc1)
         {
            conLevel.addChild(this.scenemc1);
            this.addHaidaoevent();
         }
         else
         {
            ResourceManager.getResource(ClientConfig.getAppResource("2016/0311/scene1"),function(param1:MovieClip):void
            {
               scenemc1 = param1;
               conLevel.addChild(scenemc1);
               scenemc1.x = 127.8;
               scenemc1.y = 134.2;
               addHaidaoevent();
            });
         }
      }
      
      private function addHaidaoevent() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < 6)
         {
            this.scenemc1["mc" + _loc1_].addEventListener(MouseEvent.CLICK,this.haidaoClick);
            this.scenemc1["mc" + _loc1_].buttonMode = true;
            _loc1_++;
         }
         this.scenemc1["annuo"].addEventListener(MouseEvent.CLICK,this.annuoClick);
         this.scenemc1["annuo"].buttonMode = true;
         this.updatehaidao();
      }
      
      private function annuoClick(param1:MouseEvent) : void
      {
         NpcDialog.show(NPC.ANNUO,["呜呜呜……快救救我，帮我击败这些海盗吧！"],null,null,false);
      }
      
      private function updatehaidao() : void
      {
         KTool.getMultiValue([3845],function(param1:Array):void
         {
            var _loc3_:int = 0;
            var _loc2_:Boolean = true;
            state1 = [];
            _loc3_ = 0;
            while(_loc3_ < 5)
            {
               state1.push(KTool.getBit(param1[0],_loc3_ + 1));
               if(KTool.getBit(param1[0],_loc3_ + 1) == 0)
               {
                  _loc2_ = false;
               }
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ < 6)
            {
               if(state1[_loc3_ - 1] == 1)
               {
                  scenemc1["mc" + _loc3_].gotoAndStop(2);
                  scenemc1["mc" + _loc3_].buttonMode = false;
               }
               else
               {
                  scenemc1["mc" + _loc3_].gotoAndStop(1);
               }
               _loc3_++;
            }
            if(_loc2_)
            {
               talkid = 11;
               showTalk();
            }
         });
      }
      
      private function haidaoClick(param1:MouseEvent) : void
      {
         var idx:int = 0;
         var e:MouseEvent = param1;
         idx = int(e.currentTarget.name.slice(2));
         if(this.state1[idx - 1] == 1)
         {
            return;
         }
         NpcDialog.show(NPC.HAIDAO_3,["什么人！你是谁？从哪来？到哪去？家里几口人？人均几亩地？地里几头牛？快说！"],["少废话，接招！","看我拿钻石砸晕你！","我什么都不知道。"],[function():void
         {
            SocketConnection.sendByQueue(45627,[idx],function(param1:*):void
            {
               var e:* = param1;
               FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
               {
                  FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
               });
            });
         },function():void
         {
            KTool.buyProductByCallback(246917,1,function():void
            {
               SocketConnection.sendByQueue(45628,[8476,idx],function(param1:*):void
               {
                  updatehaidao();
               });
            });
         },function():void
         {
         }],false);
      }
      
      private function removehaidoaEvent() : void
      {
         var _loc1_:int = 0;
         if(this.scenemc1)
         {
            if(this.scenemc1.parent)
            {
               this.scenemc1.parent.removeChild(this.scenemc1);
            }
            _loc1_ = 1;
            while(_loc1_ < 6)
            {
               this.scenemc1["mc" + _loc1_].removeEventListener(MouseEvent.CLICK,this.haidaoClick);
               _loc1_++;
            }
            this.scenemc1["annuo"].removeEventListener(MouseEvent.CLICK,this.annuoClick);
            this.scenemc1 = null;
         }
      }
      
      private function showFuwen() : void
      {
         this.removeMoviemc();
         this.removehaidoaEvent();
         if(this.scenemc2)
         {
            conLevel.addChild(this.scenemc2);
            this.addfuwenevent();
         }
         else
         {
            ResourceManager.getResource(ClientConfig.getAppResource("2016/0311/scene2"),function(param1:MovieClip):void
            {
               scenemc2 = param1;
               conLevel.addChild(scenemc2);
               scenemc2.x = 488.35;
               scenemc2.y = 323.7;
               addfuwenevent();
            });
         }
      }
      
      private function addfuwenevent() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < 5)
         {
            this.scenemc2["mc" + _loc1_].addEventListener(MouseEvent.CLICK,this.fuwenClick);
            this.scenemc2["mc" + _loc1_].buttonMode = true;
            _loc1_++;
         }
         this.updateFuwen();
      }
      
      private function updateFuwen(param1:Function = null) : void
      {
         var func:Function = param1;
         this.scenemc2["annuo"].gotoAndStop(1);
         KTool.getMultiValue([3846],function(param1:Array):void
         {
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc2_:Boolean = true;
            state2 = [];
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _loc4_ = 0;
               _loc5_ = 0;
               while(_loc5_ < 8)
               {
                  _loc4_ += KTool.getBit(param1[0],_loc3_ * 8 + _loc5_ + 1) * Math.pow(2,_loc5_);
                  _loc5_++;
               }
               if(_loc4_ < 2)
               {
                  _loc2_ = false;
               }
               state2.push(_loc4_);
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ < 5)
            {
               if(state2[_loc3_ - 1] == 0)
               {
                  scenemc2["mc" + _loc3_].gotoAndStop(1);
               }
               else if(state2[_loc3_ - 1] == 1)
               {
                  scenemc2["mc" + _loc3_].gotoAndStop(3);
                  scenemc2["mc" + _loc3_]["mon"].gotoAndStop(scenemc2["mc" + _loc3_]["mon"].totalFrames);
               }
               else
               {
                  scenemc2["mc" + _loc3_].gotoAndStop(1);
                  scenemc2["mc" + _loc3_].visible = false;
                  scenemc2["lock" + _loc3_].visible = false;
               }
               _loc3_++;
            }
            if(_loc2_)
            {
               scenemc2["annuo"].gotoAndStop(2);
               talkid = 17;
               showTalk();
            }
            if(func != null)
            {
               func();
            }
         });
      }
      
      private function fuwenClick(param1:MouseEvent) : void
      {
         var idx:int = 0;
         var e:MouseEvent = param1;
         idx = int(e.currentTarget.name.slice(2));
         if(this.state2[idx - 1] >= 2)
         {
            return;
         }
         if(this.state2[idx - 1] == 0)
         {
            SocketConnection.sendByQueue(45627,[idx + 5],function(param1:*):void
            {
               var e:* = param1;
               scenemc2["mc" + idx].gotoAndStop(3);
               AnimateManager.playMcAnimate(scenemc2["mc" + idx]["mon"],1,"",function():void
               {
                  scenemc2["mc" + idx]["mon"].stop();
                  updateFuwen(function():void
                  {
                     fighthandle(idx);
                  });
               });
            });
         }
         else
         {
            this.fighthandle(idx);
         }
      }
      
      private function fighthandle(param1:int) : void
      {
         var bossNames:Array = null;
         var idx:int = param1;
         bossNames = ["森德罗斯","辛基德","古夫曼","提姆提姆"];
         var npcs:Array = [NPC.SENDELUOSI,NPC.XINJIDE,NPC.GUFUMAN,NPC.TIMUTIMU];
         NpcDialog.show(npcs[idx - 1],["是谁在解开符文！这是我们伟大组织的俘虏，不可饶恕！"],["少废话，接招！","看我拿钻石砸晕你！","我什么都不知道。"],[function():void
         {
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            });
            FightManager.fightNoMapBoss(bossNames[idx - 1],6639 + idx - 1);
         },function():void
         {
            KTool.buyProductByCallback(246918,1,function():void
            {
               SocketConnection.sendByQueue(45628,[8477,idx],function(param1:*):void
               {
                  updateFuwen();
               });
            });
         },function():void
         {
         }],false);
      }
      
      private function removefuwenEvent() : void
      {
         var _loc1_:int = 0;
         if(this.scenemc2)
         {
            if(this.scenemc2.parent)
            {
               this.scenemc2.parent.removeChild(this.scenemc2);
            }
            _loc1_ = 1;
            while(_loc1_ < 5)
            {
               this.scenemc2["mc" + _loc1_].removeEventListener(MouseEvent.CLICK,this.fuwenClick);
               _loc1_++;
            }
            this.scenemc2 = null;
         }
      }
      
      private function showLastHaidao() : void
      {
         this.removeMoviemc();
         this.removefuwenEvent();
         if(this.scenemc3)
         {
            conLevel.addChild(this.scenemc3);
            this.addlasthaidaoevent();
         }
         else
         {
            ResourceManager.getResource(ClientConfig.getAppResource("2016/0311/scene3"),function(param1:MovieClip):void
            {
               scenemc3 = param1;
               conLevel.addChild(scenemc3);
               scenemc3.x = 225.45;
               scenemc3.y = 142;
               addlasthaidaoevent();
            });
         }
      }
      
      private function addlasthaidaoevent() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < 9)
         {
            this.scenemc3["mc" + _loc1_].addEventListener(MouseEvent.CLICK,this.lasthaidaoClick);
            _loc1_++;
         }
         this.updatelasthaidao();
      }
      
      private function updatelasthaidao() : void
      {
         KTool.getMultiValue([3847],function(param1:Array):void
         {
            var _loc3_:int = 0;
            var _loc2_:Boolean = true;
            state3 = [];
            _loc3_ = 0;
            while(_loc3_ < 8)
            {
               if(KTool.getBit(param1[0],_loc3_ + 1) == 0)
               {
                  _loc2_ = false;
               }
               state3.push(KTool.getBit(param1[0],_loc3_ + 1));
               _loc3_++;
            }
            _loc3_ = 1;
            while(_loc3_ < 9)
            {
               if(state3[_loc3_ - 1] == 1)
               {
                  scenemc3["mc" + _loc3_].visible = false;
               }
               _loc3_++;
            }
            if(_loc2_)
            {
               removelasthaidaoEvent();
               talkid = 28;
               playmapMovie(8,showTalk);
            }
         });
      }
      
      private function lasthaidaoClick(param1:MouseEvent) : void
      {
         var bossNames:Array = null;
         var idx:int = 0;
         var e:MouseEvent = param1;
         bossNames = ["鬼剑骷髅","玄冰之魂","拉斯特","格拉托尼","格利德","无常幽鬼","炽风烈鬼","狂刃血鬼"];
         idx = int(e.currentTarget.name.slice(2));
         NpcDialog.show(NPC.HAIDAO_3,["招惹了我们伟大的组织，就让你吃不了兜着走！"],["少废话，接招！","看我拿钻石砸晕你！","我什么都不知道。"],[function():void
         {
            FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
            {
               FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            });
            FightManager.fightNoMapBoss(bossNames[idx - 1],6643 + idx - 1);
         },function():void
         {
            KTool.buyProductByCallback(246919,1,function():void
            {
               SocketConnection.sendByQueue(45628,[8478,idx],function(param1:*):void
               {
                  updatelasthaidao();
               });
            });
         },function():void
         {
         }],false);
      }
      
      private function removelasthaidaoEvent() : void
      {
         var _loc1_:int = 0;
         if(this.scenemc3)
         {
            if(this.scenemc3.parent)
            {
               this.scenemc3.parent.removeChild(this.scenemc3);
            }
            _loc1_ = 1;
            while(_loc1_ < 9)
            {
               this.scenemc3["mc" + _loc1_].removeEventListener(MouseEvent.CLICK,this.lasthaidaoClick);
               _loc1_++;
            }
            this.scenemc3 = null;
         }
      }
      
      private function playmapMovie(param1:int, param2:Function = null, param3:Boolean = false) : void
      {
         var frame:int = param1;
         var fun:Function = param2;
         var show:Boolean = param3;
         LevelManager.iconLevel.visible = false;
         LevelManager.toolsLevel.visible = false;
         if(this.moviemc)
         {
            this.startplay(frame,fun,show);
         }
         else
         {
            ResourceManager.getResource(ClientConfig.getMapAnimate("scenemovie11171"),function(param1:MovieClip):void
            {
               moviemc = param1;
               startplay(frame,fun,show);
            });
         }
      }
      
      private function startplay(param1:int, param2:Function, param3:Boolean) : void
      {
         var frame:int = param1;
         var fun:Function = param2;
         var show:Boolean = param3;
         MapManager.currentMap.controlLevel.addChild(this.moviemc);
         this.moviemc.gotoAndStop(frame);
         KTool.hideMapAllPlayerAndMonster();
         AnimateManager.playMcAnimate(this.moviemc["mc"],1,"",function():void
         {
            if(show)
            {
               MapManager.currentMap.controlLevel.removeChild(moviemc);
               KTool.showMapAllPlayerAndMonster();
               LevelManager.iconLevel.visible = true;
               LevelManager.toolsLevel.visible = true;
            }
            if(fun != null)
            {
               fun();
            }
         });
      }
      
      private function removeMoviemc() : void
      {
         if(this.moviemc)
         {
            if(this.moviemc.parent)
            {
               this.moviemc.parent.removeChild(this.moviemc);
            }
            KTool.showMapAllPlayerAndMonster();
            LevelManager.iconLevel.visible = true;
            LevelManager.toolsLevel.visible = true;
         }
      }
      
      override public function destroy() : void
      {
      }
   }
}

