package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.controller.NewSeerTaskController;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.TasksManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import com.robot.core.utils.RectangleMask;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10013 extends BaseMapProcess
   {
      
      private static const ID:uint = 87;
      
      public function MapProcess_10013()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.y = 660;
         if(TasksManager.getTaskStatus(ID) == TasksManager.UN_ACCEPT)
         {
            TasksManager.accept(ID,function(param1:Boolean):void
            {
               if(param1)
               {
                  startPro();
               }
            });
         }
         else if(TasksManager.getTaskStatus(ID) == TasksManager.ALR_ACCEPT)
         {
            this.startPro();
         }
      }
      
      private function startPro() : void
      {
         NpcDialog.show(NPC.DOCTOR,[MainManager.actorInfo.formatNick + "，精灵是宇宙中不可思议的生物，目前我们已知有上百种，天空、大海、高山、森林、草原、到处都可以见到它们的身影！"],["精灵好神奇啊！博士，你不是说给我准备了礼物吗？我等不及了！"],[function():void
         {
            SocketConnection.send(1020,130);
            NpcDialog.show(NPC.DOCTOR,["哈哈！瞧你兴奋的样……喏，这是精灵图鉴，我把已知道的宇宙精灵资料全都记录在里面了。如果你是勇敢的冒险者，就大胆的去寻找它们吧！"],["哇！精灵图鉴，博士，太感谢你啦！"],[function():void
            {
               var book:* = undefined;
               SocketConnection.send(1020,131);
               book = MapManager.currentMap.libManager.getMovieClip("book");
               LevelManager.appLevel.addChild(book);
               AnimateManager.playMcAnimate(book,0,"",function():void
               {
                  DisplayUtil.removeForParent(book);
                  book = null;
                  SocketConnection.send(1020,132);
                  NpcDialog.show(NPC.DOCTOR,[MainManager.actorInfo.formatNick + "，想成为精灵的朋友，没有精灵胶囊可不行哦！打开0xff0000“精灵道具购买”0xffffff就可以买到哦，赶紧看看吧！"],["嗯，我来试试！"],[function():void
                  {
                     SocketConnection.send(1020,133);
                     RectangleMask.mask(new Rectangle(230,60,150,120),"",4,ClientConfig.getResPath("forApp/NewSeerTask.swf"));
                     conLevel["capsule"].buttonMode = true;
                     conLevel["capsule"].addEventListener(MouseEvent.CLICK,function(param1:MouseEvent):void
                     {
                        var e:MouseEvent = param1;
                        conLevel["capsule"].removeEventListener(MouseEvent.CLICK,arguments.callee);
                        SocketConnection.send(1020,134);
                        ModuleManager.showModule(ClientConfig.getAppModule("DrugBuyPanel"),"正在加载...");
                        RectangleMask.mask(new Rectangle(290,198,70,36),"",5,ClientConfig.getResPath("forApp/NewSeerTask.swf"));
                        RectangleMask.addEventListener(RectangleMask.GOTO_NEXT,function(param1:Event):void
                        {
                           var e:Event = param1;
                           RectangleMask.removeEventListener(RectangleMask.GOTO_NEXT,arguments.callee);
                           RectangleMask.mask(new Rectangle(356,350,100,52),"",6,ClientConfig.getResPath("forApp/NewSeerTask.swf"));
                           RectangleMask.addEventListener(RectangleMask.GOTO_NEXT,function(param1:Event):void
                           {
                              var e:Event = param1;
                              RectangleMask.removeEventListener(RectangleMask.GOTO_NEXT,arguments.callee);
                              RectangleMask.mask(new Rectangle(436,328,88,58),"",7,ClientConfig.getResPath("forApp/NewSeerTask.swf"));
                              RectangleMask.addEventListener(RectangleMask.GOTO_NEXT,function(param1:Event):void
                              {
                                 var e:Event = param1;
                                 RectangleMask.removeEventListener(RectangleMask.GOTO_NEXT,arguments.callee);
                                 RectangleMask.mask(new Rectangle(760,66,44,44),"",8,ClientConfig.getResPath("forApp/NewSeerTask.swf"));
                                 RectangleMask.addEventListener(RectangleMask.GOTO_NEXT,function(param1:Event):void
                                 {
                                    var e:Event = param1;
                                    RectangleMask.removeEventListener(RectangleMask.GOTO_NEXT,arguments.callee);
                                    RectangleMask.destroy();
                                    SocketConnection.send(1020,135);
                                    NpcDialog.show(NPC.DOCTOR,["加油哦，" + MainManager.actorInfo.formatNick + "，我相信你一定能与精灵们成为好朋友！现在去船长室报道吧，罗杰正等着你呢！"],["嗯嗯，我立刻就去！"],[function():void
                                    {
                                       SocketConnection.send(1020,136);
                                       TasksManager.complete(ID,0,function(param1:Boolean):void
                                       {
                                          if(param1)
                                          {
                                             NewSeerTaskController.startTask();
                                          }
                                       });
                                    }]);
                                 });
                              });
                           });
                        });
                     });
                  }]);
               });
            }]);
         }]);
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.y = 0;
      }
   }
}

