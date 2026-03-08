package com.robot.app.mapProcess
{
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
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
   import flash.geom.Rectangle;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_10014 extends BaseMapProcess
   {
      
      private static const ID:uint = 85;
      
      private var _isTask:Boolean;
      
      public function MapProcess_10014()
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
      
      private function onGo1(param1:Event) : void
      {
         RectangleMask.removeEventListener(RectangleMask.GOTO_NEXT,this.onGo1);
         RectangleMask.destroy();
         RectangleMask.mask(new Rectangle(151,40,244,185));
         RectangleMask.addEventListener(RectangleMask.GOTO_NEXT,this.onGo2);
      }
      
      private function onGo2(param1:Event) : void
      {
         RectangleMask.removeEventListener(RectangleMask.GOTO_NEXT,this.onGo2);
         RectangleMask.destroy();
      }
      
      private function startPro() : void
      {
         NpcDialog.show(NPC.SHIPER,[MainManager.actorInfo.formatNick + "，你打跑海盗的壮举已经传遍整个飞船啦， 真是英雄出少年啊！"],["哈哈哈，船长，你的夸奖我很受用哦！"],[function():void
         {
            SocketConnection.send(1020,137);
            NpcDialog.show(NPC.SHIPER,["你这个家伙，还真不谦虚啊，呵呵……只要你跟随0xff0000“推荐任务”0xffffff一步一步去做，我相信不用多久你一定会成为赛尔号最优秀的战士！"],["谢谢，罗杰船长，我会努力的！加油！"],[function():void
            {
               var cloth:* = undefined;
               SocketConnection.send(1020,138);
               cloth = MapManager.currentMap.libManager.getMovieClip("cloth");
               LevelManager.appLevel.addChild(cloth);
               AnimateManager.playMcAnimate(cloth,0,"",function():void
               {
                  DisplayUtil.removeForParent(cloth);
                  cloth = null;
                  SocketConnection.send(1020,139);
                  TasksManager.complete(ID,0,function(param1:Boolean):void
                  {
                     if(param1)
                     {
                        ModuleManager.showModule(ClientConfig.getAppModule("NewSeerChoosePanel"));
                     }
                  });
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

