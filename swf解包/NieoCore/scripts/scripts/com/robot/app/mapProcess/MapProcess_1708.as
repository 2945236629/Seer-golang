package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.petbag.PetBagControllerNew;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.dispatcher.FightDispatcher;
   import com.robot.core.event.PetFightEvent;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.MapStoryManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import gs.TweenLite;
   import gs.easing.Linear;
   import org.taomee.manager.EventManager;
   
   public class MapProcess_1708 extends BaseMapProcess
   {
      
      private var hasGotNormalPrize:Array = [false,false,false,false];
      
      private var animTimer:Timer;
      
      private var hasLastAlice:Boolean = false;
      
      private var isNormalSitaShow:Boolean = false;
      
      private var circleState:int = 1;
      
      private var isInDoorAnim:Boolean = false;
      
      private var isScreen:Boolean = false;
      
      private var isInEchoAnim:Boolean = false;
      
      private var echoTT:int = 0;
      
      public function MapProcess_1708()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.visible = false;
         this.animTimer = new Timer(888,7);
         this.animTimer.addEventListener(TimerEvent.TIMER,this.onEchoAnim);
         if(!MapStoryManager.IsInStory)
         {
            this.onStoryQuit();
         }
         else
         {
            this.onStoryStart();
         }
         KTool.getMultiValue([105807],function(param1:Array):void
         {
            hasGotNormalPrize[0] = KTool.getBit(param1[0],23) == 1;
            hasGotNormalPrize[1] = KTool.getBit(param1[0],24) == 1;
            hasGotNormalPrize[2] = KTool.getBit(param1[0],25) == 1;
            hasGotNormalPrize[3] = KTool.getBit(param1[0],26) == 1;
            updateEye();
         });
         EventManager.addEventListener(MapStoryManager.ON_MAP_STORY_Quit,this.onStoryQuit);
         EventManager.addEventListener(MapStoryManager.ON_MAP_STORY_START,this.onStoryStart);
         EventManager.addEventListener(MapStoryManager.ON_STORY_PUSH,this.PassQuestion);
         btnLevel["btnAct_9"].addEventListener(MouseEvent.CLICK,this.Interaction9);
         conLevel["Interaction10"].addEventListener(MouseEvent.CLICK,this.Interaction10);
         conLevel["Interaction10"].gotoAndStop(1);
         conLevel["InteractionScreen"].gotoAndStop(1);
         conLevel["Interaction9"].gotoAndStop(1);
         if(conLevel["Interaction9"]["ani"])
         {
            conLevel["Interaction9"]["ani"].gotoAndStop(1);
         }
         conLevel["floorDoor"].gotoAndStop(1);
         conLevel["Interaction8"].gotoAndStop(1);
         conLevel["Alice"].addEventListener(MouseEvent.CLICK,this.AliceDialog);
         conLevel["Sita"].addEventListener(MouseEvent.CLICK,this.SitaDialog);
         btnLevel["btnAct_3"].addEventListener(MouseEvent.CLICK,this.Interaction3);
         btnLevel["btnAct_4"].addEventListener(MouseEvent.CLICK,this.Interaction4);
         btnLevel["btnAct_5"].addEventListener(MouseEvent.CLICK,this.Interaction5);
         btnLevel["btnAct_6"].addEventListener(MouseEvent.CLICK,this.Interaction6);
         btnLevel["btnAct_7"].addEventListener(MouseEvent.CLICK,this.Interaction7);
         btnLevel["btnAct_8"].addEventListener(MouseEvent.CLICK,this.Interaction8);
         btnLevel["mmask"].visible = false;
      }
      
      override public function destroy() : void
      {
         EventManager.removeEventListener(MapStoryManager.ON_MAP_STORY_Quit,this.onStoryQuit);
         EventManager.removeEventListener(MapStoryManager.ON_MAP_STORY_START,this.onStoryStart);
         EventManager.removeEventListener(MapStoryManager.ON_STORY_PUSH,this.PassQuestion);
         btnLevel["btnAct_9"].removeEventListener(MouseEvent.CLICK,this.Interaction9);
         conLevel["Interaction10"].removeEventListener(MouseEvent.CLICK,this.Interaction10);
         conLevel["Alice"].removeEventListener(MouseEvent.CLICK,this.AliceDialog);
         conLevel["Sita"].removeEventListener(MouseEvent.CLICK,this.SitaDialog);
         btnLevel["btnAct_3"].removeEventListener(MouseEvent.CLICK,this.Interaction3);
         btnLevel["btnAct_4"].removeEventListener(MouseEvent.CLICK,this.Interaction4);
         btnLevel["btnAct_5"].removeEventListener(MouseEvent.CLICK,this.Interaction5);
         btnLevel["btnAct_6"].removeEventListener(MouseEvent.CLICK,this.Interaction6);
         btnLevel["btnAct_7"].removeEventListener(MouseEvent.CLICK,this.Interaction7);
         btnLevel["btnAct_8"].removeEventListener(MouseEvent.CLICK,this.Interaction8);
         this.animTimer.removeEventListener(TimerEvent.TIMER,this.onEchoAnim);
      }
      
      private function onStoryStart(param1:* = null) : void
      {
         var yunxiaoEquipArr:Array;
         var e:* = param1;
         conLevel["Sita"].gotoAndStop(MapStoryManager.StoryProgress <= 8 ? 1 : 2);
         yunxiaoEquipArr = [1301079,1301080,1301081,1301082];
         MapStoryManager.changeSeerEquip(yunxiaoEquipArr);
         if(MapStoryManager.StoryProgress == 7)
         {
            conLevel["Sita"].gotoAndStop(1);
            topLevel.visible = false;
            AnimateManager.playMcAnimate(topLevel["aniMc"],1,"ani",function():void
            {
               AnimateManager.playMcAnimate(topLevel["aniMc"],2,"ani",function():void
               {
                  topLevel.visible = false;
                  MapStoryManager.dialog(165,29,function(param1:int):void
                  {
                     MapStoryManager.pushNextStep();
                     if(param1 == 1)
                     {
                        FightSita();
                     }
                     else if(param1 == 2)
                     {
                        PetBagControllerNew.showByBuffer();
                     }
                  });
               });
            });
         }
         else if(MapStoryManager.StoryProgress == 9)
         {
            MapStoryManager.dialog(165,32,function(param1:int):void
            {
               MapStoryManager.pushNextStep();
            });
         }
         else if(MapStoryManager.StoryProgress == 16)
         {
            MapStoryManager.dialog(165,41,function(param1:int):void
            {
               if(param1 == 1)
               {
                  MapStoryManager.recoverSeerEquip();
                  MapStoryManager.quitStory();
                  MapManager.changeMap(1);
               }
               hasLastAlice = true;
            });
         }
         conLevel["Sita"].visible = false;
         conLevel["Alice"].visible = false;
         conLevel["In3"].gotoAndStop(1);
         conLevel["In4"].gotoAndStop(1);
         conLevel["In6"].gotoAndStop(1);
         conLevel["In7"].gotoAndStop(1);
         this.PassQuestion();
      }
      
      private function onStoryQuit(param1:* = null) : void
      {
         conLevel["Sita"].visible = false;
         conLevel["Alice"].visible = false;
         MapStoryManager.recoverSeerEquip();
         this.updateEye();
      }
      
      private function updateEye() : void
      {
         if(MapStoryManager.IsInStory == false)
         {
            conLevel["In3"].gotoAndStop(this.hasGotNormalPrize[0] ? 3 : 1);
            conLevel["In4"].gotoAndStop(this.hasGotNormalPrize[1] ? 3 : 1);
            conLevel["In6"].gotoAndStop(this.hasGotNormalPrize[2] ? 3 : 1);
            conLevel["In7"].gotoAndStop(this.hasGotNormalPrize[3] ? 3 : 1);
         }
      }
      
      private function PassQuestion(param1:* = null) : void
      {
         var e:* = param1;
         if(MapStoryManager.StoryProgress >= 16)
         {
         }
         conLevel["Sita"].gotoAndStop(MapStoryManager.StoryProgress <= 8 ? 1 : 2);
         if(MapStoryManager.StoryProgress > 8)
         {
            conLevel["Alice"].x = 594;
            conLevel["Alice"].y = 425;
         }
         else
         {
            conLevel["Alice"].x = 732.8;
            conLevel["Alice"].y = 404.7;
         }
         if(MapStoryManager.StoryProgress <= 10)
         {
            conLevel["Interaction8"].gotoAndStop(1);
         }
         else
         {
            conLevel["Interaction8"].gotoAndStop(2);
         }
         if(MapStoryManager.StoryProgress == 15)
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("MapStoryFullAnim_2"),function():void
            {
               var _loc1_:int = int(MapStoryManager.StoryProgress);
               AliceDialog(null);
            });
         }
      }
      
      private function AliceDialog(param1:*) : void
      {
         var ali:DisplayObject = null;
         var e:* = param1;
         if(e != null)
         {
            ali = e.currentTarget;
         }
         else
         {
            ali = conLevel["Alice"];
         }
         MapStoryManager.playerMoveToMc(ali,function():void
         {
            if(MapStoryManager.IsInStory == false && MapStoryManager.StoryProgress >= 1)
            {
               MapStoryManager.dialog(165,1,function(param1:int):void
               {
                  if(param1 == 1)
                  {
                     MapStoryManager.startStory();
                  }
               });
               return;
            }
            if(!MapStoryManager.IsInStory)
            {
               return;
            }
            if(MapStoryManager.StoryProgress == 8)
            {
               MapStoryManager.dialog(165,31,function(param1:int):void
               {
                  if(param1 == 1)
                  {
                     FightSita();
                  }
                  else if(param1 == 2)
                  {
                     PetBagControllerNew.showByBuffer();
                  }
               });
            }
            else if(MapStoryManager.StoryProgress == 10)
            {
               MapStoryManager.dialog(165,33,function(param1:int):void
               {
               });
            }
            else if(MapStoryManager.StoryProgress >= 16)
            {
               if(hasLastAlice == false)
               {
                  MapStoryManager.dialog(165,41,function(param1:int):void
                  {
                     if(param1 == 1)
                     {
                        MapStoryManager.recoverSeerEquip();
                        MapManager.changeMap(1);
                     }
                     hasLastAlice = true;
                  });
               }
               else
               {
                  MapStoryManager.dialog(165,42,function(param1:int):void
                  {
                     if(param1 == 1)
                     {
                        MapStoryManager.recoverSeerEquip();
                        MapManager.changeMap(1);
                     }
                  });
               }
            }
         });
      }
      
      private function SitaDialog(param1:*) : void
      {
         var e:* = param1;
         MapStoryManager.playerMoveToPos(new Point(480,488),function():void
         {
            if(!MapStoryManager.IsInStory)
            {
               MapStoryManager.dialog(165,55,function(param1:int):void
               {
                  if(param1 == 1)
                  {
                     ModuleManager.showAppModule("SceneActivityPanel");
                  }
               });
               return;
            }
            if(MapStoryManager.StoryProgress == 8)
            {
               FightSita();
            }
            else if(MapStoryManager.StoryProgress == 10)
            {
               MapStoryManager.dialog(165,34,function(param1:int):void
               {
               });
            }
            else if(MapStoryManager.StoryProgress == 16)
            {
               MapStoryManager.dialog(165,43);
            }
         });
      }
      
      private function FightSita() : void
      {
         FightDispatcher.addEventListener(PetFightEvent.ALARM_CLICK,function(param1:PetFightEvent):void
         {
            var e:PetFightEvent = param1;
            FightDispatcher.removeEventListener(PetFightEvent.ALARM_CLICK,arguments.callee);
            if(FightManager.isWin)
            {
               MapStoryManager.StoryProgress = 9;
               MapStoryManager.updateProgress().then(function():void
               {
                  if(MapStoryManager.StoryProgress == 9)
                  {
                     EventManager.dispatchEvent(new Event(MapStoryManager.ON_STORY_PUSH));
                     MapStoryManager.dialog(165,32,function(param1:int):void
                     {
                        MapStoryManager.pushNextStep();
                     });
                  }
               });
            }
         });
         FightManager.fightNoMapBoss("",18694);
      }
      
      private function Interaction3(param1:*) : void
      {
         var e:* = param1;
         if(!MapStoryManager.IsInStory)
         {
            if(!this.hasGotNormalPrize[0])
            {
               conLevel["In3"].gotoAndStop(2);
               MapStoryManager.dialog(165,56,function(param1:int):void
               {
                  SocketConnection.send(45850,[26,4]);
               });
               this.hasGotNormalPrize[0] = true;
            }
            else
            {
               conLevel["In3"].gotoAndStop(3);
               MapStoryManager.dialog(165,61);
            }
            SocketConnection.send(45850,[26,56]);
            return;
         }
         if(MapStoryManager.StoryProgress == 10)
         {
            MapStoryManager.dialog(165,36,function(param1:int):void
            {
               conLevel["In3"].gotoAndStop(3);
            });
         }
         else if(MapStoryManager.StoryProgress == 16)
         {
            MapStoryManager.dialog(165,44);
         }
      }
      
      private function Interaction4(param1:*) : void
      {
         var e:* = param1;
         if(!MapStoryManager.IsInStory)
         {
            if(!this.hasGotNormalPrize[1])
            {
               conLevel["In4"].gotoAndStop(2);
               MapStoryManager.dialog(165,57,function(param1:int):void
               {
                  SocketConnection.send(45850,[26,5]);
               });
               this.hasGotNormalPrize[1] = true;
            }
            else
            {
               conLevel["In4"].gotoAndStop(3);
               MapStoryManager.dialog(165,61);
            }
            SocketConnection.send(45850,[26,57]);
            return;
         }
         if(MapStoryManager.StoryProgress == 10)
         {
            MapStoryManager.dialog(165,37,function(param1:int):void
            {
               conLevel["In4"].gotoAndStop(3);
            });
         }
         else if(MapStoryManager.StoryProgress == 16)
         {
            MapStoryManager.dialog(165,44);
         }
      }
      
      private function Interaction5(param1:*) : void
      {
         var e:* = param1;
         if(!MapStoryManager.IsInStory)
         {
            MapStoryManager.dialog(165,58,function(param1:int):void
            {
            });
            SocketConnection.send(45850,[26,58]);
            return;
         }
         if(MapStoryManager.StoryProgress == 10)
         {
            this.playEchoAnim();
            MapStoryManager.dialog(165,38,function(param1:int):void
            {
            });
         }
         else if(MapStoryManager.StoryProgress == 16)
         {
            MapStoryManager.dialog(165,44);
         }
      }
      
      private function Interaction6(param1:*) : void
      {
         var e:* = param1;
         if(!MapStoryManager.IsInStory)
         {
            if(!this.hasGotNormalPrize[2])
            {
               conLevel["In6"].gotoAndStop(2);
               MapStoryManager.dialog(165,59,function(param1:int):void
               {
                  SocketConnection.send(45850,[26,6]);
               });
               this.hasGotNormalPrize[2] = true;
            }
            else
            {
               conLevel["In6"].gotoAndStop(3);
               MapStoryManager.dialog(165,61);
            }
            SocketConnection.send(45850,[26,59]);
            return;
         }
         if(MapStoryManager.StoryProgress == 10)
         {
            MapStoryManager.dialog(165,39,function(param1:int):void
            {
               conLevel["In6"].gotoAndStop(3);
            });
         }
         else if(MapStoryManager.StoryProgress == 16)
         {
            MapStoryManager.dialog(165,44);
         }
      }
      
      private function Interaction7(param1:*) : void
      {
         var e:* = param1;
         if(!MapStoryManager.IsInStory)
         {
            if(!this.hasGotNormalPrize[3])
            {
               conLevel["In7"].gotoAndStop(2);
               MapStoryManager.dialog(165,60,function(param1:int):void
               {
                  SocketConnection.send(45850,[26,60]);
                  SocketConnection.send(45850,[26,7]);
               });
               this.hasGotNormalPrize[3] = true;
            }
            else
            {
               conLevel["In7"].gotoAndStop(3);
               MapStoryManager.dialog(165,61);
            }
            SocketConnection.send(45850,[26,60]);
            return;
         }
         if(MapStoryManager.StoryProgress == 10)
         {
            MapStoryManager.dialog(165,40,function(param1:int):void
            {
               conLevel["In7"].gotoAndStop(3);
            });
         }
         else if(MapStoryManager.StoryProgress == 16)
         {
            MapStoryManager.dialog(165,44);
         }
      }
      
      private function Interaction8(param1:*) : void
      {
         var e:* = param1;
         MapStoryManager.playerMoveToPos(new Point(781,410),function():void
         {
            if(!MapStoryManager.IsInStory)
            {
               if(isNormalSitaShow)
               {
                  return;
               }
               isNormalSitaShow = true;
               SocketConnection.send(45850,[26,55]);
               conLevel["Sita"].visible = false;
               conLevel["Sita"].gotoAndStop(1);
               AnimateManager.playMcAnimate(conLevel["Sita"],3,"ani",function():void
               {
                  if(conLevel["Sita"])
                  {
                     conLevel["Sita"].gotoAndStop(1);
                  }
               });
               return;
            }
            if(MapStoryManager.StoryProgress == 10)
            {
               ModuleManager.showAppModule("MapStoryKeyPop");
            }
            else if(MapStoryManager.StoryProgress >= 11 && MapStoryManager.StoryProgress <= 15)
            {
               ModuleManager.showAppModule("Map1708Pass");
            }
         });
      }
      
      private function Interaction9(param1:*) : void
      {
         var e:* = param1;
         if(this.isInDoorAnim)
         {
            return;
         }
         if(!MapStoryManager.IsInStory)
         {
            if(this.circleState < 5)
            {
               this.isInDoorAnim = true;
               ++this.circleState;
               AnimateManager.playMcAnimate(conLevel["Interaction9"],this.circleState,"ani",function():void
               {
                  var speed:Number = NaN;
                  var dist:Number = NaN;
                  var tt:Number = NaN;
                  var rot:Number = NaN;
                  if(circleState == 4)
                  {
                     speed = 500;
                     dist = Point.distance(MainManager.actorModel.pos,new Point(148,288));
                     tt = dist / speed;
                     rot = dist / 180 * 90;
                     TweenLite.to(MainManager.actorModel.sprite,tt,{
                        "x":148,
                        "y":288,
                        "rotationZ":rot,
                        "scaleX":0.6,
                        "scaleY":0.6,
                        "onComplete":function():void
                        {
                           var dist2:*;
                           var tt2:*;
                           btnLevel["mmask"].visible = false;
                           dist2 = Point.distance(new Point(-250,350),new Point(148,257));
                           tt2 = dist2 / speed;
                           TweenLite.to(MainManager.actorModel.sprite,tt2,{
                              "x":-250,
                              "y":350,
                              "rotationZ":360,
                              "scaleX":0.1,
                              "scaleY":0.1,
                              "onComplete":function():void
                              {
                                 MainManager.actorModel.sprite.rotationZ = 0;
                                 MainManager.actorModel.sprite.scaleX = 1;
                                 MainManager.actorModel.sprite.scaleY = 1;
                                 SocketConnection.send(45850,[26,61]);
                                 MapManager.changeMap(26);
                              },
                              "ease":Linear.easeNone
                           });
                        },
                        "ease":Linear.easeNone
                     });
                  }
                  else
                  {
                     isInDoorAnim = false;
                  }
               });
            }
         }
         else
         {
            MapStoryManager.dialog(165,35);
         }
      }
      
      private function Interaction10(param1:*) : void
      {
         var e:* = param1;
      }
      
      private function InteractionScreen(param1:* = null) : void
      {
         if(this.isScreen)
         {
            return;
         }
         conLevel["InteractionScreen"].gotoAndPlay(2);
         this.isScreen = true;
      }
      
      private function playEchoAnim() : void
      {
         if(this.isInEchoAnim)
         {
            return;
         }
         this.isInEchoAnim = true;
         this.echoTT = 0;
         conLevel["In3"].gotoAndStop(1);
         conLevel["In4"].gotoAndStop(1);
         conLevel["In6"].gotoAndStop(1);
         conLevel["In7"].gotoAndStop(1);
         this.animTimer.reset();
         this.animTimer.start();
      }
      
      private function onEchoAnim(param1:TimerEvent) : void
      {
         var _loc2_:Array = [0,3,6,4,7,0,0,0];
         if(conLevel["In" + _loc2_[this.echoTT]])
         {
            conLevel["In3"].gotoAndStop(1);
            conLevel["In4"].gotoAndStop(1);
            conLevel["In6"].gotoAndStop(1);
            conLevel["In7"].gotoAndStop(1);
            conLevel["In" + _loc2_[this.echoTT]].gotoAndStop(4);
         }
         if(this.echoTT >= 6)
         {
            conLevel["In3"].gotoAndStop(1);
            conLevel["In4"].gotoAndStop(1);
            conLevel["In6"].gotoAndStop(1);
            conLevel["In7"].gotoAndStop(1);
            this.isInEchoAnim = false;
         }
         ++this.echoTT;
      }
   }
}

