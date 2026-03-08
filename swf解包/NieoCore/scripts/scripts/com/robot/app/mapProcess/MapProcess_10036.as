package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.CommandID;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.config.xml.PetXMLInfo;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.MapEvent;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.info.fightInfo.PetFightModel;
   import com.robot.core.info.fightInfo.attack.FightOverInfo;
   import com.robot.core.manager.ItemManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.NonoManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.MapTransEffect;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.AppModel;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.ui.alert.Alarm;
   import com.robot.core.ui.alert.Alarm2;
   import com.robot.core.ui.alert.Alert;
   import com.robot.core.ui.alert.SpecAlert;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import org.taomee.events.SocketEvent;
   import org.taomee.manager.ResourceManager;
   import org.taomee.manager.ToolTipManager;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Utils;
   
   public class MapProcess_10036 extends BaseMapProcess
   {
      
      public static var _type:int;
      
      public static var _difficult:int;
      
      private static var _monCnt:int;
      
      private static var _monID:Array;
      
      private static var _isFight:Boolean;
      
      private static var _doorMc:MovieClip;
      
      private static var _mainMc:MovieClip;
      
      private static var _animateMc:AppModel;
      
      public static var _cards:Array;
      
      public static var wheelType:int;
      
      public static var wheeelFloor:int;
      
      private static var realfloor:int;
      
      private static var leave:Boolean = false;
      
      private static var isspec:Boolean = false;
      
      private var bossidx:int;
      
      public function MapProcess_10036()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(CommandID.ACTIVEACHIEVE,25);
         ToolBarController.panel.hide();
         LevelManager.iconLevel.visible = false;
         leave = false;
         _doorMc = conLevel["door_0"];
         _mainMc = conLevel["main_mc"];
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         if(!_isFight)
         {
            MapManager.addEventListener(MapEvent.MAP_SWITCH_COMPLETE,function(param1:*):void
            {
               var e:* = param1;
               if(MapManager.currentMap.id != 10036)
               {
                  if(!leave)
                  {
                     SocketConnection.sendByQueue(42215,[1,4,0],function(param1:*):void
                     {
                     },function(param1:*):void
                     {
                     });
                  }
                  ToolBarController.panel.show();
                  LevelManager.iconLevel.visible = true;
                  MapManager.removeEventListener(MapEvent.MAP_SWITCH_COMPLETE,arguments.callee);
               }
            });
         }
         ToolTipManager.add(conLevel["leave_btn"],"太空站");
         conLevel["bagBtn"].addEventListener(MouseEvent.CLICK,this.onPetBagClick);
         conLevel["cureBtn"].addEventListener(MouseEvent.CLICK,this.onCureClick);
         conLevel["leave_btn"].addEventListener(MouseEvent.CLICK,this.onLeaveClick);
         _doorMc.addEventListener(MouseEvent.CLICK,this.doorClick);
         PetFightModel.mode = PetFightModel.MULTI_MODE;
         PetFightModel.status = PetFightModel.FIGHT_WITH_BOSS;
         if(!_isFight)
         {
            KTool.getPlayerInfo([586,588,615],function(param1:Array):void
            {
               var arr:Array = param1;
               KTool.getMultiValue([100326],function(param1:Array):void
               {
                  var arr1:Array = param1;
                  if(wheelType == 3 && arr[0] >= 21)
                  {
                     Alarm2.show("恭喜你已经通过未来命运的考验！",function():void
                     {
                        leaveFight();
                     });
                     return;
                  }
                  if(arr1[0] >= 42 && arr[1] == 2 && arr[2] == 0)
                  {
                     conLevel["floormc"].gotoAndStop(2);
                     setTimeout(function():void
                     {
                        conLevel["floormc"].txt.text = "0";
                     },200);
                     Alert.show("你之前已通过了全新命运的考验，可以选择随机进入全新命运的某一层中，是否进行命运的随机？",function():void
                     {
                        doevent(2,false,function():void
                        {
                           doevent();
                        });
                     },function():void
                     {
                        initMap();
                     });
                  }
                  else
                  {
                     initMap();
                  }
               });
            });
         }
      }
      
      private function doorClick(param1:MouseEvent) : void
      {
      }
      
      private function initMap() : void
      {
         wheeelFloor = 0;
         _doorMc.visible = false;
         _mainMc.visible = false;
         conLevel["end_mc"].visible = false;
         conLevel["goto20_mc"].visible = false;
         conLevel["hero_mc"].visible = false;
         conLevel["key_btn"].visible = false;
         conLevel["box_btn"].visible = false;
         conLevel["pet_btn"].visible = false;
         conLevel["enter_mc"].visible = false;
         conLevel["leave_btn"].enabled = false;
         conLevel["leave_btn"].mouseEnabled = false;
         this.getevent();
      }
      
      private function getevent() : void
      {
         SocketConnection.sendByQueue(42215,[1,2,0],function(param1:*):void
         {
            getcardInfo();
         },function(param1:*):void
         {
         });
      }
      
      private function getcardInfo(param1:Boolean = true) : void
      {
         var i:int = 0;
         var boo:Boolean = param1;
         var tmparr:Array = [];
         i = 0;
         while(i < 20)
         {
            tmparr.push(589 + i);
            i++;
         }
         KTool.getPlayerInfo([586,587,588].concat(tmparr),function(param1:Array):void
         {
            var arr:Array = param1;
            KTool.getMultiValue([100326],function(param1:Array):void
            {
               var tmpnum:int = 0;
               var arr1:Array = param1;
               _cards = [];
               wheelType = arr[2];
               realfloor = arr[0];
               wheeelFloor = realfloor;
               _type = arr[1];
               if(wheelType == 1 || wheelType == 2 && wheeelFloor < 21)
               {
                  conLevel["floormc"].gotoAndStop(1);
                  if(wheelType != 1)
                  {
                     wheeelFloor = Math.abs(realfloor - 21);
                  }
               }
               else if(wheelType == 3)
               {
                  conLevel["floormc"].gotoAndStop(3);
               }
               else
               {
                  wheeelFloor = realfloor - 21;
                  conLevel["floormc"].gotoAndStop(2);
               }
               setTimeout(function():void
               {
                  conLevel["floormc"].txt.text = wheeelFloor.toString();
               },200);
               _cards.push(_type);
               i = 0;
               while(i < 20)
               {
                  if(arr[3 + i] != 0 && _cards.length < 6 && i + 1 != _type)
                  {
                     _cards.push(i + 1);
                  }
                  ++i;
               }
               i = _cards.length;
               while(i < 6)
               {
                  _cards.push(_cards[Math.round(Math.random() * (_cards.length - 1))]);
                  ++i;
               }
               _cards.sort();
               if(boo)
               {
                  initAnimate();
               }
            });
         });
         this.getietmnum();
      }
      
      private function doevent(param1:int = 0, param2:Boolean = true, param3:Function = null) : void
      {
         var tmp:int = param1;
         var boo:Boolean = param2;
         var fun:Function = param3;
         SocketConnection.sendByQueue(42215,[1,3,tmp],function(param1:*):void
         {
            var e:* = param1;
            if(boo)
            {
               KTool.getPlayerInfo([586,588],function(param1:Array):void
               {
                  var boo1:Boolean = false;
                  var arr:Array = param1;
                  if(arr[1] == 1 && arr[0] >= 21 || arr[1] == 2 && (arr[0] >= 42 || arr[0] <= 0) || arr[1] == 3 && arr[0] >= 21)
                  {
                     boo1 = true;
                  }
                  if(boo1)
                  {
                     conLevel["floormc"].gotoAndStop(wheelType);
                     setTimeout(function():void
                     {
                        conLevel["floormc"].txt.text = "20";
                     },200);
                     conLevel["end_mc"].visible = true;
                     AnimateManager.playMcAnimate(conLevel["end_mc"],0,"",function():void
                     {
                        conLevel["end_mc"].visible = false;
                        leaveFight();
                     });
                     if(wheelType == 1)
                     {
                        Alarm.show("你已通过尘封命运，若想获得精灵罗德利斯，请挑战至极限模式尘封命运20层即可获得！");
                     }
                     if(wheelType == 3)
                     {
                        Alarm.show("恭喜你已通过未来命运！");
                     }
                  }
                  else
                  {
                     initMap();
                  }
               });
            }
            if(fun != null)
            {
               fun();
            }
         });
      }
      
      private function getietmnum() : void
      {
         ItemManager.updateItems([1707511],function():void
         {
            KTool.showScore(conLevel["getNumMc"],ItemManager.getNumByID(1707511));
         });
      }
      
      private function initAnimate() : void
      {
         conLevel["enter_mc"].visible = true;
         AnimateManager.playMcAnimate(conLevel["enter_mc"],0,"",function():void
         {
            conLevel["enter_mc"].visible = false;
            if(wheeelFloor != 0)
            {
               gotoAndGetMc(_mainMc,1,function():void
               {
                  gotoAndGetMc(_mainMc["normalStage_mc"],1,function():void
                  {
                     _mainMc["normalStage_mc"]["number_mc"].gotoAndStop(wheeelFloor);
                     _mainMc.visible = true;
                     AnimateManager.playMcAnimate(_mainMc,1,"normalStage_mc",function():void
                     {
                        _mainMc.visible = false;
                        _animateMc = new AppModel(ClientConfig.getAppModule("WheelAnimate"),"正在打开神秘卡牌");
                        _animateMc.setup();
                        _animateMc.show();
                        _animateMc.sharedEvents.addEventListener("TURN_COMPLETE",onAnimateComplete);
                     });
                  });
               });
            }
            else
            {
               _mainMc.visible = false;
               _animateMc = new AppModel(ClientConfig.getAppModule("WheelAnimate"),"正在打开神秘卡牌");
               _animateMc.setup();
               _animateMc.show();
               _animateMc.sharedEvents.addEventListener("TURN_COMPLETE",onAnimateComplete);
            }
         });
      }
      
      private function clearPet() : void
      {
         DisplayUtil.removeAllChild(conLevel["pet_btn"]);
      }
      
      private function fightHandle() : void
      {
         this.clearPet();
         KTool.getPlayerInfo([616,617,618,619],function(param1:Array):void
         {
            conLevel["pet_btn"].visible = true;
            _monID = [];
            bossidx = param1[0];
            var _loc2_:int = 0;
            while(_loc2_ < 3)
            {
               if(param1[_loc2_ + 1] != 0)
               {
                  _monID.push(param1[_loc2_ + 1]);
               }
               _loc2_++;
            }
            if(_monID.length > 0)
            {
               loadMonster(_monID.shift());
            }
            conLevel["pet_btn"].addEventListener(MouseEvent.CLICK,onPetClick);
         });
      }
      
      private function onAnimateComplete(param1:Event = null) : void
      {
         var e:Event = param1;
         isspec = false;
         _animateMc.sharedEvents.removeEventListener("TURN_COMPLETE",this.onAnimateComplete);
         if(wheelType == 2 && realfloor < 21 && (_type == 1 || _type == 2 || _type == 4 || _type == 6 || _type == 7) && e != null)
         {
            Alert.show("可通过挑战精灵避免你在尘封命运中越陷越深，是否进入挑战？",function():void
            {
               isspec = true;
               doevent(3,false,fightHandle);
            },function():void
            {
               onAnimateComplete(null);
            });
            return;
         }
         if(_type == 1)
         {
            this.changeFloor(1,1);
         }
         else if(_type == 3)
         {
            if(wheeelFloor == 0 && wheelType == 2)
            {
               Alert.show("可以通过挑战精灵避免落入尘封命运中，是否进入挑战？",function():void
               {
                  doevent(1,false,fightHandle);
               },function():void
               {
                  changeFloor(3,1);
               });
            }
            else
            {
               this.changeFloor(3,1);
            }
         }
         else if(_type == 2 || _type == 12 || _type == 10 || _type == 11)
         {
            this.doevent(0,false,this.fightHandle);
         }
         else if(_type == 7)
         {
            _mainMc.visible = true;
            AnimateManager.playMcAnimate(_mainMc,11,"box_mc",function():void
            {
               _mainMc.visible = false;
               conLevel["box_btn"].visible = true;
               conLevel["box_btn"].addEventListener(MouseEvent.CLICK,onBoxClick);
            });
         }
         else if(_type == 4)
         {
            this.changeFloor(1,2);
         }
         else if(_type == 6)
         {
            conLevel["hero_mc"].visible = true;
            AnimateManager.playMcAnimate(conLevel["hero_mc"],0,"",function():void
            {
               conLevel["hero_mc"].visible = false;
               doevent(0,false,fightHandle);
            });
         }
         else if(_type == 8)
         {
            _mainMc.visible = true;
            AnimateManager.playMcAnimate(_mainMc,12,"key_mc",function():void
            {
               _mainMc.visible = false;
               conLevel["key_btn"].visible = true;
               conLevel["key_btn"].addEventListener(MouseEvent.CLICK,onKeyClick);
            });
         }
         else if(_type == 5)
         {
            if(wheeelFloor == 0 && wheelType == 2)
            {
               Alert.show("可以通过挑战精灵避免落入尘封命运中，是否进入挑战？",function():void
               {
                  doevent(1,false,fightHandle);
               },function():void
               {
                  changeFloor(3,2);
               });
            }
            else
            {
               this.changeFloor(3,2);
            }
         }
         conLevel["leave_btn"].enabled = true;
         conLevel["leave_btn"].mouseEnabled = true;
      }
      
      private function loadMonster(param1:uint) : void
      {
         var monID:uint = param1;
         ResourceManager.getResource(ClientConfig.getPetSwfPath(monID),function(param1:DisplayObject):void
         {
            var _loc2_:MovieClip = param1 as MovieClip;
            (_loc2_.getChildAt(0) as MovieClip).gotoAndStop(1);
            ToolTipManager.add(_loc2_,PetXMLInfo.getName(monID));
            conLevel["pet_btn"].addChild(_loc2_);
            conLevel["pet_btn"].buttonMode = true;
            _loc2_.x = conLevel["pet_btn"].getChildIndex(_loc2_) * 60;
            if(_monID.length > 0)
            {
               loadMonster(_monID.shift());
            }
            else
            {
               conLevel["pet_btn"].x = (960 - conLevel["pet_btn"].width) / 2 + conLevel["pet_btn"].getChildAt(0).width / 2 + 5;
            }
         },"pet");
      }
      
      private function changeFloor(param1:uint, param2:int) : void
      {
         var mte:MapTransEffect;
         var dir:uint = param1;
         var count:int = param2;
         count--;
         MainManager.actorModel.visible = false;
         MainManager.actorModel.hideNono();
         mte = new MapTransEffect(MapManager.currentMap,dir);
         mte.addEventListener(MapEvent.MAP_EFFECT_COMPLETE,function(param1:MapEvent):void
         {
            DisplayUtil.removeAllChild(LevelManager.appLevel);
            DisplayUtil.removeAllChild(LevelManager.mapLevel);
            LevelManager.mapLevel.addChild(MapManager.currentMap.root);
            MainManager.actorModel.x = 492;
            MainManager.actorModel.y = 424;
            MainManager.actorModel.visible = true;
            MainManager.actorModel.showNono(NonoManager.info,MainManager.actorInfo.actionType);
            if(count > 0)
            {
               changeFloor(dir,count);
            }
            else
            {
               doevent();
            }
         });
         mte.star();
      }
      
      private function onPetClick(param1:MouseEvent) : void
      {
         conLevel["pet_btn"].removeEventListener(MouseEvent.CLICK,this.onPetClick);
         _isFight = true;
         FightManager.fightNoMapBoss("",this.bossidx);
      }
      
      private function onBoxClick(param1:MouseEvent) : void
      {
         conLevel["box_btn"].removeEventListener(MouseEvent.CLICK,this.onBoxClick);
         conLevel["box_btn"].visible = false;
         this.doevent();
      }
      
      private function onKeyClick(param1:MouseEvent) : void
      {
         conLevel["key_btn"].removeEventListener(MouseEvent.CLICK,this.onKeyClick);
         conLevel["key_btn"].visible = false;
         this.doevent();
      }
      
      private function onFightComplete(param1:PetFightEvent) : void
      {
         var e:PetFightEvent = param1;
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         _isFight = false;
         _doorMc.visible = false;
         _mainMc.visible = false;
         conLevel["end_mc"].visible = false;
         conLevel["goto20_mc"].visible = false;
         conLevel["hero_mc"].visible = false;
         conLevel["key_btn"].visible = false;
         conLevel["box_btn"].visible = false;
         conLevel["pet_btn"].visible = false;
         conLevel["enter_mc"].visible = false;
         if((e.dataObj as FightOverInfo).winnerID == MainManager.actorID)
         {
            KTool.getPlayerInfo([586,588],function(param1:Array):void
            {
               var boo:Boolean = false;
               var arr:Array = param1;
               if(arr[1] == 1 && arr[0] >= 21 || arr[1] == 2 && (arr[0] >= 42 || arr[0] <= 0) || arr[1] == 3 && arr[0] >= 21)
               {
                  boo = true;
               }
               if(!boo)
               {
                  initMap();
               }
               else
               {
                  conLevel["floormc"].gotoAndStop(wheelType);
                  setTimeout(function():void
                  {
                     conLevel["floormc"].txt.text = "20";
                  },200);
                  conLevel["end_mc"].visible = true;
                  AnimateManager.playMcAnimate(conLevel["end_mc"],0,"",function():void
                  {
                     conLevel["end_mc"].visible = false;
                     leaveFight();
                  });
                  if(wheelType == 1)
                  {
                     Alarm.show("你已通过尘封命运，若想获得精灵罗德利斯，请挑战至极限模式尘封命运20层即可获得！");
                  }
                  if(wheelType == 3)
                  {
                     Alarm.show("恭喜你已通过未来命运！");
                  }
               }
            });
         }
         else if(!isspec)
         {
            this.getcardInfo(false);
            this.fightHandle();
         }
         else
         {
            this.initMap();
         }
      }
      
      private function onPetBagClick(param1:MouseEvent) : void
      {
         PetBagControllerNew.showByBuffer();
      }
      
      private function onCureClick(param1:MouseEvent) : void
      {
         var cls:* = undefined;
         var e:MouseEvent = param1;
         if(MainManager.actorInfo.superNono)
         {
            PetManager.cureAll();
         }
         else
         {
            cls = Utils.getClass("com.robot.app.mapProcess.control.ColorfulPrivilegeWishController") as Class;
            if(cls.bonusType == 1)
            {
               PetManager.cureAll();
            }
            else
            {
               SpecAlert.show("恢复精灵体力需要花费50赛尔豆，成为超No用户即可享受永久免费恢复特权！",function():void
               {
                  PetManager.cureAll();
               });
            }
         }
      }
      
      private function onLeaveClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         Alert.show("确定要离开命运之轮吗？如果中途退出的话，需要从头开始挑战哦！",function():void
         {
            leaveFight();
         });
      }
      
      private function leaveFight() : void
      {
         SocketConnection.sendByQueue(42215,[1,4,0],function(param1:*):void
         {
            onLeaveFight(null);
         },function(param1:*):void
         {
         });
      }
      
      private function onLeaveFight(param1:SocketEvent) : void
      {
         ToolBarController.panel.show();
         LevelManager.iconLevel.visible = true;
         wheeelFloor = 0;
         _isFight = false;
         leave = true;
         MapManager.changeMap(1151);
      }
      
      private function gotoAndGetMc(param1:MovieClip, param2:int, param3:Function) : void
      {
         var mc:MovieClip = param1;
         var frame:int = param2;
         var fun:Function = param3;
         mc.addEventListener(Event.ENTER_FRAME,function(param1:Event):void
         {
            mc.removeEventListener(Event.ENTER_FRAME,arguments.callee);
            fun();
         });
         mc.gotoAndStop(frame);
      }
      
      public function onDoorClick() : void
      {
         this.changeFloor(1,1);
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         this.clearPet();
         while(_loc1_ < conLevel["pet_btn"].numberChildren)
         {
            ToolTipManager.remove(conLevel["pet_btn"].getChildAt(_loc1_));
            _loc1_++;
         }
         _doorMc.removeEventListener(MouseEvent.CLICK,this.doorClick);
         conLevel["bagBtn"].removeEventListener(MouseEvent.CLICK,this.onPetBagClick);
         conLevel["cureBtn"].removeEventListener(MouseEvent.CLICK,this.onCureClick);
         conLevel["pet_btn"].removeEventListener(MouseEvent.CLICK,this.onPetClick);
         conLevel["box_btn"].removeEventListener(MouseEvent.CLICK,this.onBoxClick);
         conLevel["key_btn"].removeEventListener(MouseEvent.CLICK,this.onKeyClick);
         FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,this.onFightComplete);
         ToolTipManager.remove(conLevel["leave_btn"]);
         conLevel["leave_btn"].removeEventListener(MouseEvent.CLICK,this.onLeaveClick);
      }
   }
}

