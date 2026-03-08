package com.robot.app.mapProcess
{
   import com.robot.app.fight.*;
   import com.robot.app.task.taskscollection.*;
   import com.robot.app.task.tc.*;
   import com.robot.app.toolBar.*;
   import com.robot.core.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.config.xml.*;
   import com.robot.core.event.*;
   import com.robot.core.info.fightInfo.attack.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import com.robot.core.ui.alert.*;
   import com.robot.core.utils.*;
   import flash.display.*;
   import flash.events.*;
   import flash.media.*;
   import flash.net.*;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.*;
   import org.taomee.utils.*;
   
   public class MapProcess_483 extends BaseMapProcess
   {
      
      public static var qingLongStatus:int;
      
      private static var _soundList:Array = [];
      
      private static var _mIndex:uint = 0;
      
      private var _petArr:Array;
      
      private var _boss:MovieClip;
      
      private var _soundPathList:Array = ["music_2.mp3","music_3.mp3"];
      
      private var checkUseItem:Boolean = false;
      
      public function MapProcess_483()
      {
         super();
      }
      
      public static function getMc(param1:MovieClip, param2:uint, param3:String = "", param4:Function = null) : void
      {
         var child:MovieClip = null;
         var parentMC:MovieClip = null;
         var name:String = null;
         var func:Function = null;
         child = null;
         parentMC = param1;
         var frame:uint = param2;
         name = param3;
         func = param4;
         parentMC.gotoAndStop(frame);
         if(name == "")
         {
            child = parentMC.getChildAt(0) as MovieClip;
         }
         else
         {
            child = parentMC.getChildByName(name) as MovieClip;
         }
         if(Boolean(child))
         {
            if(func != null)
            {
               func(child);
            }
         }
         else
         {
            parentMC.addEventListener(Event.ENTER_FRAME,function():void
            {
               if(name == "")
               {
                  child = parentMC.getChildAt(0) as MovieClip;
               }
               else
               {
                  child = parentMC.getChildByName(name) as MovieClip;
               }
               if(Boolean(child))
               {
                  parentMC.removeEventListener(Event.ENTER_FRAME,arguments.callee);
                  if(func != null)
                  {
                     func(child);
                  }
               }
            });
         }
      }
      
      private static function stopMC(param1:DisplayObjectContainer) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:MovieClip = param1 as MovieClip;
         if(Boolean(_loc4_))
         {
            _loc4_.stop();
            _loc2_ = uint(_loc4_.numChildren);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               stopMC(_loc4_.getChildAt(_loc3_) as MovieClip);
               _loc3_++;
            }
         }
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.hide();
         ToolBarController.showOrHideAllUser(false);
         EventManager.addEventListener("Error11075",this.onEError11075);
         this._petArr = new Array();
         this._boss = conLevel["boss"];
         (this._boss["bossBtn_1"] as SimpleButton).mouseEnabled = false;
         (this._boss["bossBtn_2"] as SimpleButton).mouseEnabled = false;
         (this._boss["bossBtn_3"] as SimpleButton).mouseEnabled = false;
         var _loc1_:int = 0;
         while(_loc1_ <= 4)
         {
            (conLevel["mon_" + _loc1_] as MovieClip).visible = false;
            this._petArr.push(conLevel["mon_" + _loc1_]);
            _loc1_++;
         }
         _mIndex = 0;
         this.loadMusic();
         this.gameLoop();
      }
      
      private function loadMusic() : void
      {
         var _loc1_:Sound = null;
         _loc1_ = new Sound(new URLRequest(ClientConfig.getResPath("module/ext/music/" + this._soundPathList[_mIndex])));
         _loc1_.addEventListener(Event.COMPLETE,this.onLoadSoundComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadMusicIoError);
         _soundList.push(_loc1_);
      }
      
      private function onLoadMusicIoError(param1:IOErrorEvent) : void
      {
         (param1.currentTarget as Sound).removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadMusicIoError);
         this.gameLoop();
      }
      
      private function onLoadSoundComplete(param1:Event) : void
      {
         ++_mIndex;
         if(_mIndex != this._soundPathList.length)
         {
            this.loadMusic();
         }
      }
      
      private function gameLoop() : void
      {
         switch(qingLongStatus)
         {
            case 0:
               this.initComp0();
               break;
            case 1:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp7);
               break;
            case 2:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp2);
               break;
            case 3:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp3);
               break;
            case 4:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp4);
               break;
            case 5:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp5);
               break;
            case 6:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp4);
               break;
            case 8:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp4);
               break;
            case 9:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp7);
               break;
            case 10:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp4);
               break;
            case 11:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp11);
               break;
            case 12:
               EventManager.addEventListener(PetFightEvent.ALARM_CLICK,this.initComp4);
               break;
            case 13:
               this.initComp1();
         }
      }
      
      private function initComp0() : void
      {
         getMc(this._boss,1,"mc",function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            AnimateManager.playMcAnimate(mc,0,"",function():void
            {
               var pet:MovieClip = null;
               var i:uint = 0;
               while(i <= 4)
               {
                  pet = _petArr[i];
                  pet.visible = true;
                  getMc(pet,1,"",function(param1:MovieClip):void
                  {
                     var mc:MovieClip = null;
                     mc = param1;
                     AnimateManager.playMcAnimate(mc,0,"",function():void
                     {
                        getMc(mc,mc.totalFrames,"pet_static",function(param1:MovieClip):void
                        {
                           param1.buttonMode = true;
                           param1.addEventListener(MouseEvent.CLICK,onFightMon);
                           (_boss["bossBtn_1"] as SimpleButton).mouseEnabled = true;
                           (_boss["bossBtn_1"] as SimpleButton).addEventListener(MouseEvent.CLICK,onFightMon);
                        });
                     });
                  });
                  i++;
               }
            });
         });
      }
      
      private function onFightMon(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.BAI_HU,["我是罗格星系的守护神，你能进到这里说明你已经是个能独挡一面的精英了，但是真正的挑战现在才开始。"],["不管什么挑战我都不怕。","我还是下次再来吧。"],[function():void
         {
            (_boss["bossBtn_1"] as SimpleButton).removeEventListener(MouseEvent.CLICK,onFightMon);
            SocketConnection.addCmdListener(CommandID.FIGHT_OVER,onFightOver1);
            FightManager.fightWithBoss("白虎守护兽",0,true);
         },function():void
         {
            MapManager.changeMap(1);
         }],true);
      }
      
      private function checkFightSymbol() : void
      {
         ItemManager.upDateCollection(1700252,function():void
         {
            if(ItemManager.getNumByID(1700252) > 0)
            {
               checkUseItem = true;
               SocketConnection.sendWithCallback(46050,function(param1:SocketEvent):void
               {
                  SocketConnection.addCmdListener(CommandID.FIGHT_OVER,onFightOver6);
                  FightManager.fightWithBoss("泰格尔",1,true);
               },3);
            }
            else
            {
               Alarm.show("你还没有白虎战符！");
            }
         });
      }
      
      private function initComp1(param1:PetFightEvent = null) : void
      {
         var i:uint = 0;
         var pet:MovieClip = null;
         var event:PetFightEvent = param1;
         EventManager.removeEventListener(PetFightEvent.ALARM_CLICK,this.initComp1);
         i = 0;
         while(i <= 4)
         {
            pet = this._petArr[i];
            pet.visible = true;
            getMc(pet,2,"",function(param1:MovieClip):void
            {
               var mc:MovieClip = null;
               mc = param1;
               AnimateManager.playMcAnimate(mc,0,"",function():void
               {
                  mc.parent.visible = false;
               });
            });
            i++;
         }
         getMc(this._boss,3,"mc",function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            if(Boolean(_soundList[0]))
            {
               (_soundList[0] as Sound).play();
            }
            AnimateManager.playMcAnimate(mc,0,"",function():void
            {
               (_boss["bossBtn_1"] as SimpleButton).mouseEnabled = false;
               (_boss["bossBtn_2"] as SimpleButton).mouseEnabled = true;
               (_boss["bossBtn_3"] as SimpleButton).mouseEnabled = true;
               (_boss["bossBtn_2"] as SimpleButton).addEventListener(MouseEvent.CLICK,onMouseFightHu);
               (_boss["bossBtn_3"] as SimpleButton).addEventListener(MouseEvent.CLICK,onMouseWrieHu);
            });
         });
      }
      
      private function onMouseFightHu(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.BAI_HU,["想战胜我？没那么容易！"],["我一定会打败你。","我还是下次再来吧。"],[function():void
         {
            SocketConnection.addCmdListener(CommandID.FIGHT_OVER,onFightOver2);
            FightManager.fightWithBoss("战虎",3,true);
         },function():void
         {
            getMc(_boss,2,"",function(param1:MovieClip):void
            {
               var mc:* = undefined;
               mc = param1;
               AnimateManager.playMcAnimate(mc,0,"",function():void
               {
                  DisplayUtil.removeForParent(mc.parent);
                  MapManager.changeMap(1);
               });
            });
         }]);
      }
      
      private function onMouseWrieHu(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.BAI_HU,["别来妨碍我，我才是这个身体的统治者！"],["我一定会打败你。","我还是下次再来吧。"],[function():void
         {
            SocketConnection.addCmdListener(CommandID.FIGHT_OVER,onFightOver4);
            FightManager.fightWithBoss("电虎",1,true);
         },function():void
         {
            getMc(_boss,2,"",function(param1:MovieClip):void
            {
               var mc:* = undefined;
               mc = param1;
               AnimateManager.playMcAnimate(mc,0,"",function():void
               {
                  DisplayUtil.removeForParent(mc.parent);
                  MapManager.changeMap(1);
               });
            });
         }]);
      }
      
      private function initComp1Helper() : void
      {
         var pet:MovieClip = null;
         pet = null;
         Task142.getMc(this._boss,2,"mc",function(param1:MovieClip):void
         {
            var i:int = 0;
            var mc:MovieClip = param1;
            mc.buttonMode = true;
            mc.addEventListener(MouseEvent.CLICK,fightBoss);
            i = 0;
            while(i < 4)
            {
               pet = _petArr[i];
               Task142.getMc(pet,2,"",function(param1:MovieClip):void
               {
                  var mc:MovieClip = null;
                  mc = param1;
                  AnimateManager.playMcAnimate(mc,0,"",function():void
                  {
                     DisplayUtil.removeForParent(mc.parent);
                  });
               });
               i++;
            }
         });
      }
      
      private function initComp2(param1:PetFightEvent) : void
      {
         var i:uint = 0;
         var pet:MovieClip = null;
         var event:PetFightEvent = param1;
         EventManager.removeEventListener(PetFightEvent.ALARM_CLICK,this.initComp2);
         i = 0;
         while(i <= 4)
         {
            pet = this._petArr[i];
            pet.visible = true;
            getMc(pet,2,"",function(param1:MovieClip):void
            {
               stopMC(param1.parent);
            });
            i++;
         }
         getMc(this._boss,1,"mc",function(param1:MovieClip):void
         {
            stopMC(param1.parent);
         });
         NpcDialog.show(NPC.BAI_HU,["等你的实力有长足的进步时再来吧！"],["我还是下次再来吧。"],[function():void
         {
            var index:* = undefined;
            index = undefined;
            var pet:* = undefined;
            index = 0;
            var i:* = 0;
            while(i <= 4)
            {
               pet = _petArr[i];
               getMc(pet,2,"",function(param1:MovieClip):void
               {
                  var mc:* = undefined;
                  mc = param1;
                  AnimateManager.playMcAnimate(mc,0,"",function():void
                  {
                     ++index;
                     if(index == 5)
                     {
                        getMc(_boss,2,"mc",function(param1:MovieClip):void
                        {
                           var mc:* = undefined;
                           mc = param1;
                           AnimateManager.playMcAnimate(mc,0,"",function():void
                           {
                              DisplayUtil.removeForParent(mc.parent);
                              MapManager.changeMap(1);
                           });
                        });
                     }
                     DisplayUtil.removeForParent(mc.parent);
                  });
               });
               i++;
            }
         }]);
      }
      
      private function initComp3(param1:PetFightEvent) : void
      {
         var event:PetFightEvent = param1;
         EventManager.removeEventListener(PetFightEvent.ALARM_CLICK,this.initComp3);
         getMc(this._boss,4,"mc",function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            AnimateManager.playMcAnimate(mc,0,"",function():void
            {
               (_boss["bossBtn_3"] as SimpleButton).mouseEnabled = true;
               (_boss["bossBtn_3"] as SimpleButton).addEventListener(MouseEvent.CLICK,onMouseBigWireHu);
            });
         });
      }
      
      private function initComp4(param1:PetFightEvent) : void
      {
         var i:int = 0;
         var pet:MovieClip = null;
         var event:PetFightEvent = param1;
         EventManager.removeEventListener(PetFightEvent.ALARM_CLICK,this.initComp4);
         i = 0;
         while(i < 4)
         {
            pet = this._petArr[i];
            DisplayUtil.removeForParent(pet);
            i++;
         }
         Task142.getMc(this._boss,1,"mc",function(param1:MovieClip):void
         {
            stopMC(param1.parent);
         });
         NpcDialog.show(NPC.BAI_HU,["等你的实力有长足的进步时再来吧！"],["我还是下次再来吧。"],[function():void
         {
            Task142.getMc(_boss,2,"mc",function(param1:MovieClip):void
            {
               var mc:* = undefined;
               mc = param1;
               AnimateManager.playMcAnimate(mc,0,"",function():void
               {
                  DisplayUtil.removeForParent(mc.parent);
                  MapManager.changeMap(1);
               });
            });
         }]);
      }
      
      private function initComp5(param1:PetFightEvent) : void
      {
         var event:PetFightEvent = param1;
         EventManager.removeEventListener(PetFightEvent.ALARM_CLICK,this.initComp5);
         getMc(this._boss,5,"mc",function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            AnimateManager.playMcAnimate(mc,0,"",function():void
            {
               (_boss["bossBtn_2"] as SimpleButton).mouseEnabled = true;
               (_boss["bossBtn_2"] as SimpleButton).addEventListener(MouseEvent.CLICK,onMouseBigFightHu);
            });
         });
      }
      
      private function initComp7(param1:PetFightEvent) : void
      {
         var event:PetFightEvent = param1;
         EventManager.removeEventListener(PetFightEvent.ALARM_CLICK,this.initComp7);
         getMc(this._boss,6,"mc",function(param1:MovieClip):void
         {
            var mc:MovieClip = param1;
            if(Boolean(_soundList[1]))
            {
               (_soundList[1] as Sound).play();
            }
            AnimateManager.playMcAnimate(mc,0,"",function():void
            {
               (_boss["bossBtn_1"] as SimpleButton).mouseEnabled = true;
               (_boss["bossBtn_1"] as SimpleButton).addEventListener(MouseEvent.CLICK,fightTrueHu);
            });
         });
      }
      
      private function initComp11(param1:PetFightEvent) : void
      {
         var id:int = 0;
         var name:String = null;
         id = 0;
         name = null;
         var event:PetFightEvent = param1;
         getMc(this._boss,1,"mc",function(param1:MovieClip):void
         {
            stopMC(param1.parent);
         });
         if(TasksManager.getTaskStatus(147) == TasksManager.COMPLETE)
         {
            id = int(TaskClass_147.spriteID);
            name = ItemXMLInfo.getName(id);
            TaskClass_147.spriteID = -1;
            NpcDialog.show(NPC.BAI_HU,["我为你感到骄傲！请收下我的精元，我将与你同在！"],["我不会让你失望的。"],[function():void
            {
               Task142.getMc(_boss,2,"mc",function(param1:MovieClip):void
               {
                  var mc:* = undefined;
                  mc = param1;
                  AnimateManager.playMcAnimate(mc,0,"",function():void
                  {
                     ItemInBagAlert.show(id,"1个" + TextFormatUtil.getRedTxt(name) + "已经放入你的储存箱！",function():void
                     {
                        DisplayUtil.removeForParent(mc.parent);
                        MapManager.changeMap(1);
                     });
                  });
               });
            }]);
         }
         else
         {
            MapManager.changeMap(1);
         }
      }
      
      private function fightTrueHu(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.BAI_HU,["你的表现令我震惊，你愿意接受最后的考验吗？"],["我愿意接受最后的考验。","我还是下次再来吧。"],[function():void
         {
            SocketConnection.addCmdListener(CommandID.FIGHT_OVER,onFightOver6);
            FightManager.fightWithBoss("泰格尔",1,true);
         },function():void
         {
            MapManager.changeMap(1);
         }]);
      }
      
      private function onMouseBigWireHu(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.BAI_HU,["哈哈，电虎的能力已经被我吸收，我才是真正的王！"],["我不会怕你的！","我还是下次再来吧。"],[function():void
         {
            SocketConnection.addCmdListener(CommandID.FIGHT_OVER,onFightOver5);
            FightManager.fightWithBoss("电虎",4,true);
         },function():void
         {
            getMc(_boss,2,"mc",function(param1:MovieClip):void
            {
               var mc:* = undefined;
               mc = param1;
               AnimateManager.playMcAnimate(mc,0,"",function():void
               {
                  DisplayUtil.removeForParent(mc.parent);
                  MapManager.changeMap(1);
               });
            });
         }]);
      }
      
      private function onMouseBigFightHu(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(NPC.BAI_HU,["哈哈，战虎的能力已经被我吸收，我才是真正的王！"],["我不会怕你的！","我还是下次再来吧。"],[function():void
         {
            SocketConnection.addCmdListener(CommandID.FIGHT_OVER,onFightOver3);
            FightManager.fightWithBoss("战虎",2,true);
         },function():void
         {
            getMc(_boss,2,"mc",function(param1:MovieClip):void
            {
               var mc:* = undefined;
               mc = param1;
               AnimateManager.playMcAnimate(mc,0,"",function():void
               {
                  DisplayUtil.removeForParent(mc.parent);
                  MapManager.changeMap(1);
               });
            });
         }]);
      }
      
      private function onFightOver1(param1:SocketEvent) : void
      {
         var event:SocketEvent = param1;
         var fightInfo:FightOverInfo = event.data as FightOverInfo;
         SocketConnection.removeCmdListener(CommandID.FIGHT_OVER,this.onFightOver1);
         if(fightInfo.winnerID == MainManager.actorInfo.userID)
         {
            qingLongStatus = 1;
            BufferRecordManager.setState(MainManager.actorInfo,128,true,function():void
            {
            });
         }
         else
         {
            qingLongStatus = 2;
         }
         this.init();
      }
      
      private function fightBoss(param1:MouseEvent) : void
      {
         SocketConnection.addCmdListener(CommandID.FIGHT_OVER,this.onFightOver2);
         FightManager.fightWithBoss("战白虎",1,true);
      }
      
      private function onFightOver2(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.FIGHT_OVER,this.onFightOver2);
         if((param1.data as FightOverInfo).winnerID == MainManager.actorID)
         {
            qingLongStatus = 3;
         }
         else
         {
            qingLongStatus = 4;
         }
         this.init();
      }
      
      private function onFightOver3(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.FIGHT_OVER,this.onFightOver3);
         if((param1.data as FightOverInfo).winnerID == MainManager.actorID)
         {
            qingLongStatus = 7;
         }
         else
         {
            qingLongStatus = 8;
         }
      }
      
      private function onFightOver4(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.FIGHT_OVER,this.onFightOver4);
         if((param1.data as FightOverInfo).winnerID == MainManager.actorID)
         {
            qingLongStatus = 5;
         }
         else
         {
            qingLongStatus = 6;
         }
      }
      
      private function onFightOver5(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.FIGHT_OVER,this.onFightOver5);
         if((param1.data as FightOverInfo).winnerID == MainManager.actorID)
         {
            qingLongStatus = 9;
         }
         else
         {
            qingLongStatus = 10;
         }
      }
      
      private function onFightOver6(param1:SocketEvent) : void
      {
         SocketConnection.removeCmdListener(CommandID.FIGHT_OVER,this.onFightOver6);
         if((param1.data as FightOverInfo).winnerID == MainManager.actorID)
         {
            qingLongStatus = 11;
         }
         else
         {
            qingLongStatus = 12;
         }
      }
      
      private function onEError11075(param1:RobotEvent) : void
      {
         var event:RobotEvent = param1;
         EventManager.removeEventListener("Error11075",this.onEError11075);
         NpcDialog.show(NPC.BAI_HU,["白虎空间出现了异常状况，你必须立刻离开这里。"],["嗯，我知道啦~~"],[function():void
         {
            MapManager.changeMap(1);
         }]);
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.showOrHideAllUser(true);
         ToolBarController.panel.show();
         this._boss = null;
         this._petArr = null;
         _soundList.splice(0);
      }
   }
}

