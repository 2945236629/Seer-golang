package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.SystemTimerManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NpcDialogNew_1;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11366 extends BaseMapProcess
   {
      
      private var curState:int = 0;
      
      public function MapProcess_11366()
      {
         super();
      }
      
      override protected function init() : void
      {
         KTool.getMultiValue([100719],function(param1:Array):void
         {
            if(KTool.subByte(param1[0],12,4) == 0)
            {
               SocketConnection.sendWithCallback(42306,update,6,4);
            }
            else
            {
               update();
            }
            conLevel.addEventListener(MouseEvent.CLICK,onMouseClick);
         });
         LevelManager.toolsLevel.visible = false;
         LevelManager.iconLevel.visible = false;
      }
      
      private function onMouseClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(e.target.name == "btn_1")
         {
            if(this.curState == 0)
            {
               NpcDialogNew_1.show(1,["是你啊" + MainManager.actorInfo.formatNick + "，很久没见，这次十一狂欢开启，感觉如何？"],["很好！我很满意！"],[function():void
               {
                  NpcDialogNew_1.show(20,["船长，我也很久没有见你了，十一你是不是给我带好东西了啊？"],["额....怎么上来就要礼物！"],[function():void
                  {
                     NpcDialogNew_1.show(1,["好吧......我和站长还有博士，都给你准备了几道问题！答对了就给你礼物！"],["快出题吧！"],[function():void
                     {
                        answerQ(1);
                     }]);
                  }]);
               }]);
            }
            else if(this.curState > 0)
            {
               this.answerQ(5);
            }
         }
         if(e.target.name == "btn_2")
         {
            if(this.curState == 1)
            {
               NpcDialogNew_1.show(11,[MainManager.actorInfo.formatNick + "，你来！最近如何？没有停止努力吧？"],["当然没有！"],[function():void
               {
                  NpcDialogNew_1.show(20,["嘿嘿！站长大人！您真是越来越帅了！"],["少拍马屁！回答对问题才有奖励！"],[function():void
                  {
                     NpcDialogNew_1.show(20,["好吧......站长还是那么严厉......"],["准备好！"],[function():void
                     {
                        answerQ1(1);
                     }]);
                  }]);
               }]);
            }
            else if(this.curState > 1)
            {
               this.answerQ1(5);
            }
         }
         if(e.target.name == "btn_3")
         {
            if(this.curState == 2)
            {
               NpcDialogNew_1.show(3,["唉！这不是" + MainManager.actorInfo.formatNick + "吗？最近过的如何？"],["博士！好想你啊！最近有新发明吗？"],[function():void
               {
                  NpcDialogNew_1.show(20,["快点给我看看！我好期待啊！"],["......我看你心思肯定不在发明上！"],[function():void
                  {
                     NpcDialogNew_1.show(20,["......礼物拿来！"],["那我就要考考你了！"],[function():void
                     {
                        answerQ2(1);
                     }]);
                  }]);
               }]);
            }
         }
         if(e.target.name == "close")
         {
            MapManager.changeMapWithCallback(1,function():void
            {
            });
         }
      }
      
      private function answerQ(param1:int, param2:Boolean = false) : void
      {
         var i:int = param1;
         var error:Boolean = param2;
         if(error)
         {
            NpcDialogNew_1.show(20,["回答错误！再来一次吧！"],["好！","暂时不想回答问题了！"],[function():void
            {
               answerQ(i);
            },function():void
            {
            }]);
            return;
         }
         switch(i)
         {
            case 1:
               NpcDialogNew_1.show(20,["听好了啊！问题一：\n   大暗黑天长老中，谁的代号是“命”？"],["A. 天邪龙皇"," B. 冥皇•修罗","C. 魔王•咤克斯","D. 邪冥•兽皇"],[function():void
               {
                  answerQ(1,true);
               },function():void
               {
                  answerQ(2);
               },function():void
               {
                  answerQ(1,true);
               },function():void
               {
                  answerQ(1,true);
               }]);
               break;
            case 2:
               NpcDialogNew_1.show(20,["不错不错，问题二：\n大暗黑天长老中，谁曾经困住了卡修斯？"],["A. 天邪龙皇"," B. 魔王•咤克斯","C. 万古邪皇•威斯克 ","D. 天蛇太祖"],[function():void
               {
                  answerQ(3);
               },function():void
               {
                  answerQ(2,true);
               },function():void
               {
                  answerQ(2,true);
               },function():void
               {
                  answerQ(2,true);
               }]);
               break;
            case 3:
               NpcDialogNew_1.show(20,["不错！问题三：\n大暗黑天长老中，上四长老的代号统称为："],["A. 大暗黑天 "," B. 乌云闭月","C. 天命难违 ","D. 世道沦常"],[function():void
               {
                  answerQ(3,true);
               },function():void
               {
                  answerQ(3,true);
               },function():void
               {
                  answerQ(4);
               },function():void
               {
                  answerQ(3,true);
               }]);
               break;
            case 4:
               NpcDialogNew_1.show(20,["最后一个问题：\n大暗黑天长老中，谁负责除掉盖亚？"],["A. 飞镰"," B. 邪冥•兽皇","C. 冥帝•修罗","D. 万古邪皇•威斯克"],[function():void
               {
                  curState = 1;
                  answerQ(5);
               },function():void
               {
                  answerQ(4,true);
               },function():void
               {
                  answerQ(4,true);
               },function():void
               {
                  answerQ(4,true);
               }]);
               break;
            case 5:
               NpcDialogNew_1.show(20,["恭喜你已经答对了全部的问题！去看看站长或者博士有没有问题吧！"],["好的！"],[function():void
               {
               }]);
         }
      }
      
      private function answerQ1(param1:int, param2:Boolean = false) : void
      {
         var i:int = param1;
         var error:Boolean = param2;
         if(error)
         {
            NpcDialogNew_1.show(11,["回答错误！再来一次吧！"],["好！","暂时不想回答问题了！"],[function():void
            {
               answerQ1(i);
            },function():void
            {
            }]);
            return;
         }
         switch(i)
         {
            case 1:
               NpcDialogNew_1.show(11,["问题一：\n   莱茵哈特代表的元素之力是？"],["A. 草系"," B. 地面","C. 战斗","D. 暗影"],[function():void
               {
                  answerQ(11,true);
               },function():void
               {
                  answerQ1(2);
               },function():void
               {
                  answerQ1(1,true);
               },function():void
               {
                  answerQ1(1,true);
               }]);
               break;
            case 2:
               NpcDialogNew_1.show(11,["不错不错，问题二：\n  格劳瑞把力量传承给了哪个精灵？"],["A. 雷伊"," B. 盖亚","C. 布莱克 ","D. 卡修斯"],[function():void
               {
                  answerQ1(3);
               },function():void
               {
                  answerQ1(2,true);
               },function():void
               {
                  answerQ1(2,true);
               },function():void
               {
                  answerQ1(2,true);
               }]);
               break;
            case 3:
               NpcDialogNew_1.show(11,["不错！问题三：\n传承给缪斯力量的是谁？"],["A. 格劳瑞 "," B. 霍德尔","C. 海瑟薇 ","D. 阿尔斯兰"],[function():void
               {
                  answerQ1(3,true);
               },function():void
               {
                  answerQ1(3,true);
               },function():void
               {
                  answerQ1(4);
               },function():void
               {
                  answerQ1(3,true);
               }]);
               break;
            case 4:
               NpcDialogNew_1.show(11,["最后一个问题：\n谁最后一个获得了传承之力？"],["A. 雷伊 "," B. 缪斯","C. 米咔","D. 盖亚"],[function():void
               {
                  answerQ1(4,true);
               },function():void
               {
                  answerQ1(4,true);
               },function():void
               {
                  answerQ1(4,true);
               },function():void
               {
                  curState = 2;
                  answerQ1(5);
               }]);
               break;
            case 5:
               NpcDialogNew_1.show(11,["恭喜你已经答对了全部的问题！去看看船长或者博士有没有问题吧！"],["好的！"],[function():void
               {
               }]);
         }
      }
      
      private function answerQ2(param1:int, param2:Boolean = false) : void
      {
         var i:int = param1;
         var error:Boolean = param2;
         if(error)
         {
            NpcDialogNew_1.show(3,["回答错误！再来一次吧！"],["好！","暂时不想回答问题了！"],[function():void
            {
               answerQ2(i);
            },function():void
            {
            }]);
            return;
         }
         switch(i)
         {
            case 1:
               NpcDialogNew_1.show(3,["问题一：\n  本次十一神兽放送，一共放送几个神兽？"],["A. 1"," B. 2","C. 3","D. 4"],[function():void
               {
                  answerQ2(1,true);
               },function():void
               {
                  answerQ2(1,true);
               },function():void
               {
                  answerQ2(1,true);
               },function():void
               {
                  answerQ2(2);
               }]);
               break;
            case 2:
               NpcDialogNew_1.show(3,["不错不错，问题二：\n  盖亚最终成为哪一系的精灵王？"],["A. 战斗"," B. 火","C. 水  ","D. 草"],[function():void
               {
                  answerQ2(3);
               },function():void
               {
                  answerQ2(2,true);
               },function():void
               {
                  answerQ2(2,true);
               },function():void
               {
                  answerQ2(2,true);
               }]);
               break;
            case 3:
               NpcDialogNew_1.show(3,["不错！问题三：\n参与本次天天好礼放送，你最多可拿到几天的奖励？"],["A. 2 "," B. 4","C. 5 ","D. 7"],[function():void
               {
                  answerQ2(3,true);
               },function():void
               {
                  answerQ2(3,true);
               },function():void
               {
                  answerQ2(4);
               },function():void
               {
                  answerQ2(3,true);
               }]);
               break;
            case 4:
               NpcDialogNew_1.show(3,["最后一个问题：\n10月3号，哪个精灵也完成封王？"],["A. 米咔 "," B. 万妖王•摩哥斯","C. 黄金龙鹰","D. 千夜死神"],[function():void
               {
                  answerQ2(4,true);
               },function():void
               {
                  answerQ2(5);
               },function():void
               {
                  answerQ2(4,true);
               },function():void
               {
                  answerQ2(4,true);
               }]);
               break;
            case 5:
               AnimateManager.playMcAnimate(conLevel as MovieClip,1,"mc",function():void
               {
                  var curDate:Date = null;
                  curDate = SystemTimerManager.sysBJDate;
                  SocketConnection.sendWithCallback(42306,function():void
                  {
                     if(curDate.date == 4 && curDate.hours == 15 && curDate.minutes >= 30)
                     {
                        SocketConnection.sendWithCallback(42306,function():void
                        {
                           ModuleManager.showAppModule("MoreGiftForNationDayPanel");
                        },5,4);
                     }
                     else
                     {
                        ModuleManager.showAppModule("MoreGiftForNationDayAwardPanel");
                     }
                  },7,0);
               });
         }
      }
      
      private function update(param1:* = null) : void
      {
      }
      
      override public function destroy() : void
      {
         conLevel.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
         LevelManager.toolsLevel.visible = true;
         LevelManager.iconLevel.visible = true;
      }
   }
}

